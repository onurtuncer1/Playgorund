import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

Rectangle {

    Layout.alignment:  Qt.AlignBottom

    SplitView.minimumHeight: 100
    color: "pink"

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            id: tabBar
            Layout.fillWidth: true

            TabButton {
                text: qsTr("Search")
                width: implicitWidth
                onClicked: stackLayout.currentIndex = 0
            }
            TabButton {
                text: qsTr("Log")
                width: implicitWidth
                onClicked: stackLayout.currentIndex = 1
            }
            TabButton {
                text: qsTr("Activity")
                width: implicitWidth
                onClicked: stackLayout.currentIndex = 2
            }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                id: homeTab
                color: "black"
                Label {
                    text: "Search Content"
                    color: "white"
                    anchors.centerIn: parent
                }
            }

           LogTab{
                id: logTab
            }

            Rectangle {
                id: activityTab
                color: "lightblue"
                Label {
                    text: "Activity Content"
                    color: "black"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
