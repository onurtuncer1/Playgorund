import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Rectangle {
    implicitWidth: 200
    SplitView.maximumWidth: 400
    color: "lightblue"

    ColumnLayout {
        anchors.fill: parent

        TabBar {
            id: tabBar
            Layout.fillWidth: implicitWidth  // Ensures it spans the width of the parent

            TabButton {
                text: qsTr("Project")
                Layout.preferredWidth: implicitWidth  // Use Layout property for width
                onClicked: stackLayout.currentIndex = 0
            }
        }

        StackLayout {
            id: stackLayout
            Layout.fillWidth: true  // Makes the layout span the width of the parent
            Layout.fillHeight: true  // Makes the layout span the height of the parent

            POUTree {
                id: pouTree
               
            }
        }
    }
}





// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 2.15

// Rectangle {
//     implicitWidth: 200
//     SplitView.maximumWidth: 400
//     color: "lightblue"

//     ColumnLayout {
//         anchors.fill: parent

//         TabBar {
//             id: tabBar
//             Layout.fillWidth: true

//             TabButton {
//                 text: qsTr("Project")
//                 width: implicitWidth
//                 onClicked: stackLayout.currentIndex = 0
//             }     
//         }

//         StackLayout {
//             id: stackLayout
//             Layout.fillWidth: true
//             Layout.fillHeight: true

//             POUTree{
//                 id: pouTree
//             }
            
//         }
//     }
// }