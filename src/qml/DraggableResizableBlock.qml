// DraggableResizableBlock.qml
import QtQuick 6.0

Rectangle {
    id: block
    property int blockWidth: 150
    property int blockHeight: 100
    property color blockColor: "#3498db"
    property var inputLabels: []
    property var outputLabels: []

    width: blockWidth
    height: blockHeight
    color: blockColor
    border.color: "black"

    // Make block draggable
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        onPositionChanged: {
            // Constrain movement within parent bounds
            if (block.parent) {
                block.x = Math.max(0, Math.min(block.x, block.parent.width - block.width));
                block.y = Math.max(0, Math.min(block.y, block.parent.height - block.height));
            }
        }
    }

    // Input ports and labels on the left
    Repeater {
        model: inputLabels.length
        Item {
            width: 15
            height: block.height / inputLabels.length
            x: 0
            y: index * (block.height / inputLabels.length)

            // Dashed line for input port
            Canvas {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 10
                height: parent.height
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.setLineDash([4, 2]); // Dashed pattern
                    ctx.strokeStyle = "black";
                    ctx.beginPath();
                    ctx.moveTo(0, height / 2);
                    ctx.lineTo(width, height / 2);
                    ctx.stroke();
                }
            }

            // Input label
            Text {
                text: inputLabels[index]
                color: "white"
                font.pixelSize: 12
                anchors.left: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 5
            }
        }
    }

    // Output ports and labels on the right
    Repeater {
        model: outputLabels.length
        Item {
            width: 15
            height: block.height / outputLabels.length
            x: block.width - width
            y: index * (block.height / outputLabels.length)

            // Dashed line for output port
            Canvas {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                width: 10
                height: parent.height
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.setLineDash([4, 2]); // Dashed pattern
                    ctx.strokeStyle = "black";
                    ctx.beginPath();
                    ctx.moveTo(width, height / 2);
                    ctx.lineTo(0, height / 2);
                    ctx.stroke();
                }
            }

            // Output label
            Text {
                text: outputLabels[index]
                color: "white"
                font.pixelSize: 12
                anchors.right: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 5
            }
        }
    }
}
