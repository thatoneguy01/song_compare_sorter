

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.5
import QtQuick.Controls 6.5

Rectangle {
    id: rectangle
    width: 960
    height: 540
    color: "#eaeaea"





    Rectangle {
        id: left_rectangle
        objectName: "compare"
        color: "#eaeaea"
        anchors.left: parent.left
        anchors.right: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Text {
            id: left_song_name
            objectName: "left_song_name"
            y: 0
            text: qsTr("Left Song Name")
            anchors.top: parent.top
            font.pixelSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 70
        }

        Text {
            id: left_song_movie
            objectName: "left_song_movie"
            x: 44
            text: qsTr("Left Song Movie")
            anchors.left: left_song_name.left
            anchors.top: left_song_name.bottom
            font.pixelSize: 16
            anchors.leftMargin: 0
            anchors.topMargin: 0
        }

        Button {
            id: left_button
            y: 403
            text: qsTr("Left")
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 40

            Connections {
                target: left_button
                onClicked: backend.left_button_clicked()
            }
        }

        Image {
            id: left_image
            objectName: "left_image"
            x: 40
            anchors.left: parent.left
            anchors.right: left_rectangle.right
            anchors.top: left_song_movie.bottom
            anchors.bottom: left_button.top
            source: "template_image.png"
            anchors.bottomMargin: 20
            anchors.topMargin: 20
            anchors.leftMargin: 40
            anchors.rightMargin: 40
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: right_rectangle
        x: 5
        y: 5
        color: "#eaeaea"
        anchors.left: parent.horizontalCenter
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        Text {
            id: right_song_name
            objectName: "right_song_name"
            y: 0
            text: qsTr("Left Song Name")
            anchors.top: parent.top
            font.pixelSize: 24
            anchors.topMargin: 70
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: right_song_movie
            objectName: "right_song_movie"
            x: 44
            text: qsTr("Left Song Movie")
            anchors.left: right_song_name.left
            anchors.top: right_song_name.bottom
            font.pixelSize: 16
            anchors.topMargin: 0
            anchors.leftMargin: 0
        }

        Button {
            id: right_button
            y: 403
            text: qsTr("Right")
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 40

            Connections {
                target: right_button
                onClicked: backend.right_button_clicked()
            }
        }

        Image {
            id: right_image
            objectName: "right_image"
            x: 40
            anchors.left: parent.left
            anchors.right: right_rectangle.right
            anchors.top: right_song_movie.bottom
            anchors.bottom: right_button.top
            source: "template_image.png"
            fillMode: Image.PreserveAspectFit
            anchors.topMargin: 20
            anchors.rightMargin: 40
            anchors.leftMargin: 40
            anchors.bottomMargin: 20
        }
        anchors.topMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 6
        anchors.bottomMargin: 0
    }
    Text {
        id: title
        text: qsTr("Which is Better?")
        anchors.top: parent.top
        font.pixelSize: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
    }
    Button {
        id: equal_button
        y: 486
        text: qsTr("Equal")
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 40

        Connections {
            target: equal_button
            onClicked: backend.equals_button_clicked()
        }
    }
    Text {
        id: or_text
        text: qsTr("Or")
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 24
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
