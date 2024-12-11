import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

MenuBar {
    Menu {
        title: "File"

         MenuItem {
            text: "New"
           // onTriggered: fileDialog.open()
        }

        MenuItem {
            text: "Open"
            onTriggered: fileDialog.open()
        }
        
        MenuItem {
            text: "Exit"
            onTriggered: Qt.quit()
        }
    }

    Menu {
        title: "Help"
        MenuItem {
            text: "About"
            onTriggered: aboutDialog.open()
        }
    }
}