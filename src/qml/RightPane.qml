import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Rectangle {
    implicitWidth: 150
    SplitView.minimumWidth: 100
    color: "lightblue"

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            TabButton {
                text: qsTr("Library")
                width: implicitWidth
                onClicked: stackLayout.currentIndex = 0
            }
            TabButton {
                text: qsTr("Debug")
                width: implicitWidth
                onClicked: stackLayout.currentIndex = 1
            }
           
        }

        StackLayout {
            id: stackLayout
            // Layout.fillWidth: true
            // Layout.fillHeight: true

            LibraryTab{
                id: libraryTab
            }

            DebugTab{
                id: debugTab
            }
            
        }
    }

}