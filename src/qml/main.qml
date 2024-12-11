import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0
import QtQuick.Dialogs 

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "MILTEKSAN PLC Editor"

    header: Header{}

    menuBar: TopMenuBar{
        id: menuBar
    }

    FileDialog {
        id: fileDialog
        title: "Open File"
        nameFilters: ["All Files (*)"]
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
        }
    }

    FileDialog {
        id: saveAsDialog
        title: "Save as File"
        nameFilters: ["All Files (*)"]
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        LeftPane {
            id: left
        }

        Rectangle {
            id: right
            SplitView.minimumWidth: 50
            SplitView.minimumHeight: 300

            SplitView.fillWidth: true
            color: "lightgray"

            SplitView {
                anchors.fill: parent
                orientation: Qt.Vertical
               
                Rectangle {
                    implicitHeight: 300
                    SplitView.minimumHeight: 300
                   
                    color: "gray"
                    Label {
                        text: "Sub View 1"
                        anchors.centerIn: parent
                    }

                    SplitView {
                        anchors.fill: parent
                        orientation: Qt.Horizontal
                        SplitView.minimumHeight: 300

                        CentralPane {
                            id: centralPane
                            anchors.left: parent.left
                        }

                        // FormView {
                        //     id: formView
                        //     anchors.fill: parent
                        // }
               
                        RightPane {
                            id: rightPane
                            anchors.right: parent.right
                        }                 
                    }
                }

                BottomPanel{}   

            }
        }
    }

    AboutDialog {
        id: aboutDialog
    }

    footer: Footer{}
}
