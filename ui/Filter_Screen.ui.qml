

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
    objectName: "filter"
    width: 960
    height: 540

    color: Constants.backgroundColor

    Text {
        id: title
        text: qsTr("Yes or No?")
        anchors.top: parent.top
        font.pixelSize: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
    }

    Image {
        id: image
        objectName: "image"
        y: 490
        width: 334
        anchors.top: song_movie.bottom
        anchors.bottom: parent.bottom
        source: "template_image.png"
        cache: false
        anchors.bottomMargin: 40
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Button {
        id: no_button
        objectName: "no_button"
        x: 636
        text: qsTr("No")
        anchors.verticalCenter: image.verticalCenter
        anchors.right: image.left
        font.pointSize: 16
        autoExclusive: false
        anchors.rightMargin: 20
        checkable: false

        Connections {
            target: no_button
            onClicked: backend.no_button_clicked()
        }
    }

    Button {
        id: yes_button
        objectName: "yes_button"
        text: qsTr("Yes")
        anchors.verticalCenter: image.verticalCenter
        anchors.left: image.right
        font.pointSize: 16
        anchors.leftMargin: 20
        checkable: false

        Connections {
            target: yes_button
            onClicked: backend.yes_button_clicked()
        }
    }

    Text {
        id: song_name
        objectName: "song_name"
        text: qsTr("Song Name")
        anchors.top: title.bottom
        font.pixelSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
    }
    
    Text {
        id: song_movie
        objectName: "song_movie"
        text: qsTr("Song Movie")
        anchors.left: song_name.left
        anchors.top: song_name.bottom
        font.pixelSize: 16
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }

    Button {
        id: start_button
        objectName: "start_button"
        text: qsTr("Button")
        anchors.fill: parent

        Connections {
            target: start_button
            onClicked: start_button.visible = false
        }

        Connections {
            target: button
            onClicked: backend.start_button_clicked()
        }
    }
}
