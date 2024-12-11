import QtQuick
import QtQuick.Controls

TreeView {
    id: treeView
    anchors.fill: parent
    model: treeModel

    delegate: Item {
        id: delegateItem
        implicitWidth: 150
        implicitHeight: 40  // Ensure each row has a minimum height

        // Explicitly declare the properties required by the delegate
        required property int depth
        required property bool hasChildren
        required property bool expanded
        required property int row
        required property int column

        readonly property real indentation: 20  // Define indentation for tree levels

        Rectangle {
            id: background
            anchors.fill: parent
        //  color: row === treeView.currentRow ? "#e0f7fa" : "white"
        //  border.color: "#cccccc"
        //  border.width: 1

        // Witness Lines
            Canvas {
                id: witnessLines
                anchors.fill: parent
                anchors.leftMargin: depth * indentation - indentation / 2
                anchors.verticalCenter: parent.verticalCenter
                width: indentation
                height: parent.height

                onPaint: {
                    const ctx = witnessLines.getContext("2d");
                //  ctx.clearRect(0, 0, witnessLines.width, witnessLines.height);

                    ctx.strokeStyle = "#999";
                    ctx.lineWidth = 1;

                    // Draw vertical line
                    if (depth > 0) {
                        ctx.beginPath();
                        ctx.moveTo(witnessLines.width / 2, 0);
                        ctx.lineTo(witnessLines.width / 2, witnessLines.height);
                        ctx.stroke();
                    }

                    // Draw horizontal line
                    if (hasChildren) {
                        ctx.beginPath();
                        ctx.moveTo(witnessLines.width / 2, witnessLines.height / 2);
                        ctx.lineTo(witnessLines.width, witnessLines.height / 2);
                        ctx.stroke();
                    }
                }
            }

            // Plus/minus toggle for expanding/collapsing
            Rectangle {
                id: toggleButton
                width: 16
                height: 16
                color: "#fff"
                border.color: "#000"
                border.width: 1
                radius: 2
                x: depth * indentation
                anchors.verticalCenter: parent.verticalCenter
                visible: hasChildren

                Text {
                    anchors.centerIn: parent
                    text: expanded ? "-" : "+"
                    font.pixelSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        treeView.toggleExpanded(row);
                        witnessLines.requestPaint();  // Force redraw of witness lines
                    }
                }
            }

            // Node label
            Label {
                anchors.verticalCenter: parent.verticalCenter
                x: toggleButton.visible ? toggleButton.x + toggleButton.width + 5 : depth * indentation +  toggleButton.x + toggleButton.width + 5
                text: model.display
                font.pixelSize: 14
                color: "black"
            }
        }
    }
}
