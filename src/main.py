from PyQt6.QtCore import QObject, pyqtSlot, pyqtSignal, QUrl
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

from BasicTree import TreeModel, TreeItem

from Backend import Backend

import sys
import os

def create_sample_tree():
    root = TreeItem(["Root"])
    child1 = TreeItem(["Child 1"], root)
    child2 = TreeItem(["Child 2"], root)
    root.add_child(child1)
    root.add_child(child2)
    child1.add_child(TreeItem(["Child 1.1"], child1))
    return root

if __name__ == "__main__":

    import sys

    # Create the application
    app = QGuiApplication(sys.argv)

    # Load the QML engine
    engine = QQmlApplicationEngine()

    backend = Backend()
    engine.rootContext().setContextProperty("backend", backend)

    # Create and set the model
    root_item = create_sample_tree()
    model = TreeModel(root_item)
    engine.rootContext().setContextProperty("treeModel", model)

    qml_file_path = os.path.abspath("qml/CanvasMain.qml")
    # qml_file_path = os.path.abspath("qml/main.qml")
    print(f"Loading QML file from: {qml_file_path}")
#    engine.warnings.connect(lambda warning: print(f"QML Warning: {warning.toString()}"))
    engine.load(QUrl.fromLocalFile(qml_file_path))

    # Check for errors
    if not engine.rootObjects():
        print("Failed to load QML file. Exiting...")
        sys.exit(-1)

    sys.exit(app.exec())
