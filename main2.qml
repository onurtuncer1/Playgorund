import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Resizable Split View Example"
    minimumWidth: 600
    minimumHeight: 400

    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem {
                text: "Exit"
                onTriggered: Qt.quit()
            }
        }

        Menu {
            title: "Help"
            MenuItem {
                text: "About"
                onTriggered: aboutDialog.open()
            }
        }
    }

     SplitView {
        anchors.fill: parent

        Pane {
            width: 250
            minimumWidth: 150
            maximumWidth: 400
            Rectangle {
                color: "#f0f0f0"
                anchors.fill: parent
                Text {
                    anchors.centerIn: parent
                    text: "Left Pane"
                    font.pointSize: 16
                }
            }
        }

        Pane {
            width: 250
            minimumWidth: 150
            maximumWidth: 400
            Rectangle {
                color: "#f0f0f0"
                anchors.fill: parent
                Text {
                    anchors.centerIn: parent
                    text: "Left Pane"
                    font.pointSize: 16
                }
            }

        }
    }

    Dialog {
        id: aboutDialog
        title: "About"
        modal: true
        standardButtons: Dialog.Ok
        Text {
            text: "Resizable Split View Example using PyQt and QML\nVersion 1.0"
            wrapMode: Text.WordWrap
        }
    }
}




