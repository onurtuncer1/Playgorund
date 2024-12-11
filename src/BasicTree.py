from PyQt6.QtCore import QAbstractItemModel, QModelIndex, Qt
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

class TreeItem:
    def __init__(self, values, parent=None):
        self.values = values
        self.parent = parent
        self.children = []
        self.depth = 0  # Depth of this node in the tree

    def add_child(self, item):
        self.children.append(item)

    def child(self, row):
        return self.children[row] if 0 <= row < len(self.children) else None

    def child_count(self):
        return len(self.children)

    def column_count(self):
        return len(self.values)  # Updated to match renamed attribute

    def get_data(self, column):  # Renamed method
        return self.values[column] if 0 <= column < len(self.values) else None

    def parent_item(self):
        return self.parent

    def row(self):
        if self.parent:
            return self.parent.children.index(self)
        return 0


class TreeModel(QAbstractItemModel):
    def __init__(self, root, parent=None):
        super().__init__(parent)
        self.root = root

    def rowCount(self, parent=QModelIndex()):
        try:
            parent_item = parent.internalPointer() if parent.isValid() else self.root
            return parent_item.child_count()
        except Exception as e:
            print(f"Error in rowCount: {e}")
            return 0

    def columnCount(self, parent=QModelIndex()):
        try:
            return self.root.column_count()
        except Exception as e:
            print(f"Error in columnCount: {e}")
            return 0

    def data(self, index, role=Qt.ItemDataRole.DisplayRole):
        try:
            if not index.isValid() or role != Qt.ItemDataRole.DisplayRole:
                return None
            item = index.internalPointer()
            return item.get_data(index.column())  # Updated method call
        except Exception as e:
            print(f"Error in data: {e}")
            return None

    def index(self, row, column, parent=QModelIndex()):
        try:
            parent_item = parent.internalPointer() if parent.isValid() else self.root
            child_item = parent_item.child(row)
            if child_item:
                child_item.depth = parent_item.depth + 1 if parent.isValid() else 0
                return self.createIndex(row, column, child_item)
            return QModelIndex()
        except Exception as e:
            print(f"Error in index: {e}")
        return QModelIndex()

    def parent(self, index):
        try:
            if not index.isValid():
                return QModelIndex()
            child_item = index.internalPointer()
            parent_item = child_item.parent_item()
            if parent_item == self.root or not parent_item:
                return QModelIndex()
            return self.createIndex(parent_item.row(), 0, parent_item)
        except Exception as e:
            print(f"Error in parent: {e}")
            return QModelIndex()







