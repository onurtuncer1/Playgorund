import QtQuick 6.0
import QtQuick.Controls 6.0

 Dialog {
    id: aboutDialog
    title: "About"
    modal: true
    standardButtons: Dialog.Ok
    Text {
        text: "Resizable Split View Example using PyQt and QML\nVersion 1.0"
        wrapMode: Text.WordWrap
    }
}
