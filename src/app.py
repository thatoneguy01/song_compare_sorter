import csv, urllib.request, asyncio
from sort import mergeSort
import logging
import threading
import time

from PyQt6.QtCore import QTimer, QObject, pyqtSignal, QThread
from PyQt6.QtCore import pyqtSlot
from PyQt6 import QtGui


class DisneySong:
    def __init__(self, uid, song_name, movie, image_url):
        self.id = uid
        self.name = song_name
        self.movie = movie
        self.image_url = image_url
        self.unranked = False
        self.compare_map = {}
    
    def to_string(self):
        return self.name+", "+self.movie

class DisneySongSorter:
    
    def __init__(self):
        self.songs = []
        with open("disney_songs copy.csv") as csvfile:
            rdr = csv.reader(csvfile)
            index = 0
            for row in rdr:
                self.songs.append(DisneySong(index, *row))
                index+=1

    def get_song(self, uid):
        return self.songs[uid]
    
    def mark_unranked(self, uid):
        self.songs[uid].unranked = True
        
    def resolve_compare(self, winner_id, loser_id, equal=False):
        winner = self.songs[winner_id]
        loser = self.songs[loser_id]
        if not equal:
            winner.compare_map[loser_id] = 1
            loser.compare_map[winner_id] = -1
        else:
            winner.compare_map[loser_id] = 0
            loser.compare_map[winner_id] = 0

class Backend(QObject):
    
    def __init__(self, root):
        super().__init__()
        self.sorter = DisneySongSorter()
        self.root = root
        self.next_id = 0
        self.compare_reult = -99
        self.sorted = []
        self.threads = []

    def current_song(self):
        return self.sorter.songs[self.next_id]
    
    def get_song(self, uid):
        return self.sorter.get_song(uid)

    def find_object(self, name):
        return self.root.findChild(QObject, name)

    def display_next_song(self):
        current_song = self.current_song()
        image = self.find_object("image")
        song_name = self.find_object("song_name")
        movie = self.find_object("song_movie")
        image.setProperty("source", current_song.image_url)
        song_name.setProperty("text", current_song.name)
        movie.setProperty("text", current_song.movie)
        self.next_id += 1

    
    @pyqtSlot()
    def no_button_clicked(self):
        print("no")
        self.current_song().unranked = True
        if self.next_id < len(self.sorter.songs):
            self.display_next_song()
        else:
            self.filter_done()
            
    
    @pyqtSlot()
    def yes_button_clicked(self):
        print("yes")
        if self.next_id < len(self.sorter.songs):
            self.display_next_song()
        else:
            self.filter_done()

    def filter_done(self):
        to_be_sorted = [s for s in self.sorter.songs if not s.unranked]
        screen = self.find_object("filter_screen")
        screen.setProperty("visible", False)
        th1 = self.SortThread(self, to_be_sorted)
        th1.any_signal.connect(self.update_compare)
        th1.done_signal.connect(self.handle_results)
        self.threads.append(th1)
        th1.start()


    def update_compare(self, left, right):
        left_song_name = self.find_object("left_song_name")
        left_movie = self.find_object("left_song_movie")
        left_image = self.find_object("left_image")
        right_song_name = self.find_object("right_song_name")
        right_movie = self.find_object("right_song_movie")
        right_image = self.find_object("right_image")
        left_song_name.setProperty("text", self.get_song(left).name)
        left_movie.setProperty("text", self.get_song(left).movie)
        left_image.setProperty("source", self.get_song(left).image_url)
        right_song_name.setProperty("text", self.get_song(right).name)
        right_movie.setProperty("text", self.get_song(right).movie)
        right_image.setProperty("source", self.get_song(right).image_url)


    class SortThread(QThread):
        
        any_signal = pyqtSignal(int, int)
        done_signal = pyqtSignal()
        def __init__(self, backend, to_sort):
            super().__init__()
            self.backend = backend
            self.to_sort = to_sort
            self.complete = False
            self.cache = {}
        
        def run(self):
            print("Thread Starting...")
            def compare(song1, song2):
                if (song1.id, song2.id) in self.cache.keys():
                    return self.cache[(song1.id, song2.id)]
                elif (song2.id, song1.id) in self.cache.keys():
                    return -1*self.cache[(song2.id, song1.id)]
                self.any_signal.emit(song1.id, song2.id)
                print("Waiting on selection...")
                while self.backend.compare_reult == -99:
                    time.sleep(.1)
                print("Got Result...")
                value = self.backend.compare_reult
                self.backend.compare_reult = -99
                self.cache[(song1.id, song2.id)] = value
                return value
            
            mergeSort(self.to_sort, compare)
            self.backend.sorted = self.to_sort
            print("done")
            self.done_signal.emit()


    def handle_results(self):
        self.threads[0].quit()
        with open("results.txt", 'w') as f:
            for song in self.sorted:
                f.write(song.to_string()+"\n")
        

    @pyqtSlot()
    def left_button_clicked(self):
        self.compare_reult = 1

    @pyqtSlot()
    def equal_button_clicked(self):
        self.compare_reult = 0

    @pyqtSlot()
    def right_button_clicked(self):
        self.compare_reult = -1

    @pyqtSlot()
    def start_button_clicked(self):
        print("start")
        self.display_next_song()