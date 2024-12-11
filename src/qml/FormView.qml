import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Dialogs 

Item {
    anchors.fill: parent

    Column {
        spacing: 10
        anchors.centerIn: parent

        Label {
            text: "Company Name"
        }
        TextField {
            id: companyName
            placeholderText: "Enter company name"
            width: parent.width * 0.8
            text: companyNameText // Bind the field to the property
        }

        Label {
            text: "Product Name"
        }
        TextField {
            id: productName
            placeholderText: "Enter product name"
            width: parent.width * 0.8
            text: productNameText // Bind the field to the property
        }

        Label {
            text: "Product Version"
        }
        TextField {
            id: productVersion
            placeholderText: "Enter product version"
            width: parent.width * 0.8
            text: productVersionText // Bind the field to the property
        }

        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "Save to XML"
                onClicked: saveFileDialog.open()
            }

            Button {
                text: "Load from XML"
                onClicked: loadFileDialog.open()
            }
        }
    }

    // Save File Dialog
    FileDialog {
        id: saveFileDialog
        title: "Save XML File"
        nameFilters: ["XML Files (*.xml)"]
        onAccepted: {
            backend.saveToXml(fileUrl)
        }
        onRejected: console.log("Save file dialog was canceled")
    }

    // Load File Dialog
    FileDialog {
        id: loadFileDialog
        title: "Load XML File"
        nameFilters: ["XML Files (*.xml)"]
        onAccepted: {
            backend.loadFromXml(fileUrl)
        }
        onRejected: console.log("Load file dialog was canceled")
    }

    // Bindable properties for loaded data
    property string companyNameText: ""
    property string productNameText: ""
    property string productVersionText: ""

    Connections {
        target: backend
        onCompanyNameChanged: companyNameText = arguments[0]
        onProductNameChanged: productNameText = arguments[0]
        onProductVersionChanged: productVersionText = arguments[0]
    }
}
