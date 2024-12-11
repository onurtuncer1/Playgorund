import QtQuick 6.0
import QtQuick.Controls 
import QtQuick.Layouts 

SplitView {
    Layout.fillWidth: true
    Layout.fillHeight: true
    orientation: Qt.Vertical

    ScrollView {
        id: scrollView
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        width: implicitWidth
        height: implicitHeight
        clip: true

        TextArea {
            id: textArea
            wrapMode: TextArea.Wrap // Enable word wrap
            placeholderText: "Enter your text here..."
            text: "This is an example of a scrollable text area. You can add as much text as you like, and it will automatically scroll when the content exceeds the visible area. "
        }
    }

    ScrollView {
        id: explanationScrollView
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        width: implicitWidth
        height: implicitHeight
        clip: true
        
        TextArea {
            id: explanation
            // width: parent.width
            // height: contentHeight
            wrapMode: TextArea.Wrap // Enable word wrap
            placeholderText: "Enter your text here..."
            text: "This is an example of a scrollable text area. You can add as much text as you like, and it will automatically scroll when the content exceeds the visible area. "
        }
    }

}

