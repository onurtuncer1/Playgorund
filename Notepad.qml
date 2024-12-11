import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3

ApplicationWindow {
    visible: true
    width: 1000
    height: 700
    title: "Notepad++-Like Editor"

    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem {
                text: "New Tab"
                onTriggered: tabView.addTab("Untitled", "")
            }
            MenuItem {
                text: "Open File..."
                onTriggered: fileDialog.open()
            }
            MenuItem {
                text: "Save Current Tab"
                onTriggered: {
                    if (tabView.currentIndex >= 0) {
                        tabView.saveTab(tabView.currentIndex);
                    }
                }
            }
            MenuItem {
                text: "Save All"
                onTriggered: tabView.saveAllTabs()
            }
            MenuItem {
                text: "Exit"
                onTriggered: Qt.quit()
            }
        }
    }

    FileDialog {
        id: saveDialog
        title: "Save File"
        selectExisting: false
        onAccepted: {
            saveToFile(fileUrls[0], saveDialogIndex);
        }
    }

    property int saveDialogIndex: -1 // To track which tab is being saved

    function saveTab(index) {
        const tabData = tabModel.get(index);
        if (tabData.filePath === "") {
            saveDialogIndex = index; // Store the tab index
            saveDialog.open(); // Open the file dialog
        } else {
            saveToFile(tabData.filePath, index);
        }
    }

    function saveToFile(filePath, index) {
        console.log("Saving tab", index, "to", filePath);
        // Add file writing logic here
    }


    TabView {
        id: tabView
        anchors.fill: parent

        ListModel {
            id: tabModel
        }

        function addTab(title, content, filePath = "") {
            tabModel.append({ title: title, content: content, filePath: filePath });
            currentIndex = tabModel.count - 1;
        }

        function removeTab(index) {
            if (index >= 0 && index < tabModel.count) {
                tabModel.remove(index);
            }
        }

        function saveTab(index) {
            const tabData = tabModel.get(index);
            if (tabData.filePath === "") {
                const saveDialog = FileDialog {
                    title: "Save File"
                    selectExisting: false
                    onAccepted: {
                        saveToFile(fileUrls[0], index);
                    }
                };
                saveDialog.open();
            } else {
                saveToFile(tabData.filePath, index);
            }
        }

        function saveAllTabs() {
            for (let i = 0; i < tabModel.count; i++) {
                saveTab(i);
            }
        }

        function saveToFile(filePath, index) {
            const tabData = tabModel.get(index);
            tabData.filePath = filePath;
            tabModel.set(index, tabData);
            const file = Qt.createQmlObject('import QtQuick.LocalStorage 2.0; QtObject {}', tabView).file;
            file.open(filePath, "w");
            file.write(tabData.content);
            file.close();
        }

        function openFile(filePath) {
            const file = Qt.createQmlObject('import QtQuick.LocalStorage 2.0; QtObject {}', tabView).file;
            file.open(filePath, "r");
            const content = file.readAll();
            file.close();
            addTab(filePath.split("/").pop(), content, filePath);
        }

        function moveTab(fromIndex, toIndex) {
            if (fromIndex >= 0 && toIndex >= 0 && fromIndex < tabModel.count && toIndex < tabModel.count) {
                const item = tabModel.get(fromIndex);
                tabModel.remove(fromIndex);
                tabModel.insert(toIndex, item);
            }
        }

        Repeater {
            model: tabModel

            Tab {
                id: draggableTab
                title: model.title

                TextArea {
                    id: textArea
                    anchors.fill: parent
                    text: model.content
                    wrapMode: TextArea.Wrap
                    onTextChanged: {
                        tabModel.set(index, { title: title, content: text, filePath: model.filePath });
                    }
                }

                Rectangle {
                    id: dragArea
                    width: parent.width
                    height: 10
                    color: "transparent"

                    Drag.active: dragHandler.active
                    Drag.hotSpot.x: dragHandler.centroid.x
                    Drag.hotSpot.y: dragHandler.centroid.y
                    Drag.source: dragHandler

                    DragHandler {
                        id: dragHandler

                        onActiveChanged: {
                            if (!active) {
                                const newIndex = Math.round(dragHandler.centroid.y / draggableTab.height);
                                if (newIndex !== index) {
                                    tabView.moveTab(index, newIndex);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
