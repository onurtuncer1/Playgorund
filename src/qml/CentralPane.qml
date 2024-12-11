import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts

Rectangle {
    id: centralPane
    implicitWidth: 300
    color: "lightblue"

    ListModel {
        id: listModel
    }

    // property alias activePane: currentPane

    // Tracks the currently active pane
    // property Item currentPane: null

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            id: tabBar
            width: parent.width

            Repeater {
                model: listModel
                TabButton {
                    contentItem: RowLayout {
                        spacing: 5

                        Label {
                            text: model.filename
                        }

                        Button {
                            text: "X"
                            background: Rectangle { color: "transparent" }
                            onClicked: {
                                centralPane.removeTab(index)
                            }
                        }
                    }

                    onClicked: stackLayout.currentIndex = index
                }
            }
        }

        // Dynamic content associated with tabs
        StackLayout {
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true

            Repeater {
                model: listModel
                Loader {
                    anchors.fill: parent
                    source: model.qmlFile  // Dynamically load the QML file
                }
            }
        }
    }

    // Function to add a new tab dynamically
    function addTab(filename, qmlFilePath) {
        // Check if tab is already open
        for (let i = 0; i < listModel.count; i++) {
            if (listModel.get(i).filename === filename) {
                // Switch focus to the tab's pane
                stackLayout.currentIndex = i;
                setActivePane(centralPane);
                return;
            }
        }
        // Add new tab
        listModel.append({ filename: filename, qmlFile: qmlFilePath });
        stackLayout.currentIndex = listModel.count - 1; // Switch to the newly added tab
        // setActivePane(centralPane);
    }

    // Function to remove a tab
    function removeTab(index) {
        listModel.remove(index);
        if (stackLayout.currentIndex >= listModel.count) {
            stackLayout.currentIndex = listModel.count - 1; // Update index to the last tab
        }
    }

    // // Function to set active pane
    // function setActivePane(pane) {
    //     if (currentPane !== pane) {
    //         // Logic to manage focus if switching from one pane to another
    //         currentPane = pane;
    //         // Optionally add animations or transitions here if needed
    //     }
    // }
}




// import QtQuick 6.0
// import QtQuick.Controls 6.0
// import QtQuick.Layouts

// Rectangle {
//     id: centralPane
//     implicitWidth: 300
//     color: "lightblue"

//     ListModel {
//         id: listModel
//     }

//     ColumnLayout {
//         anchors.fill: parent

//         TabBar {
//             id: tabBar
//             width: parent.width

//             // Dynamically create TabButton items
//             Repeater {
//                 model: listModel
//                 TabButton {
//                     text: model.filename
//                     onClicked: stackLayout.currentIndex = index
//                 }
//             }
//         }

//         // Dynamic content associated with tabs
//         StackLayout {
//             id: stackLayout
//             Layout.fillWidth: true
//             Layout.fillHeight: true

//             Repeater {
//                 model: listModel
//                 Loader {
//                     anchors.fill: parent
//                     source: model.qmlFile  // Dynamically load the QML file
//                 }
//             }
//         }
//     }

//     // Function to add a new tab dynamically
//     function addTab(filename, qmlFilePath) {
//         listModel.append({ filename: filename, qmlFile: qmlFilePath })
//         stackLayout.currentIndex = listModel.count - 1; // Switch to the newly added tab
//     }
// }

