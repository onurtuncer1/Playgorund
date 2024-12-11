import QtQuick 6.0
import QtQuick.Controls 6.0
import "serialization.js" as Serializer

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "FBD Blocks with Dashed Line Ports"

    // Use Rectangle for background color
    Rectangle {
        id: background
        anchors.fill: parent
        color: "#f0f0f0" // Set the background color

        // Draggable blocks must be children of Canvas
        Canvas {
    id: canvas
    anchors.fill: parent

    // Blocks must be direct children of Canvas
    DraggableResizableBlock {
        id: block1
        x: 100
        y: 100
        blockColor: "#1abc9c"
        inputLabels: ["In1", "In2", "In3"]
        outputLabels: ["Out1", "Out2"]
    }

    DraggableResizableBlock {
        id: block2
        x: 300
        y: 200
        blockColor: "#e74c3c"
        inputLabels: ["A", "B"]
        outputLabels: ["X", "Y", "Z"]
    }
}


        // Button to serialize blocks
        Button {
            text: "Serialize Blocks"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                console.log(Serializer.serializeBlocksToXML(canvas));
            }
        }
    }
}

