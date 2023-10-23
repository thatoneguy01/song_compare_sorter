import sys

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject

from app import Backend

app = QGuiApplication(sys.argv)

engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('ui/App.qml')

threads = {}

backend = Backend(engine.rootObjects()[0])
engine.rootContext().setContextProperty("backend", backend)

sys.exit(app.exec())