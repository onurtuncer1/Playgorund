from BasicTree import TreeModel, TreeItem

class ProjectTree(TreeModel):
    def __init__(self, root, parent=None):
        super().__init__(root, parent)

    def populate_with_pous(self, pous):
        # Clear the existing tree
        self.clear()

        # Create the root item
        root_item = TreeItem(["Project Root"])
        self.set_root_item(root_item)

        # Add POUs node under the root
        pous_item = TreeItem(["POUs"])
        root_item.append_child(pous_item)

        # Add each POU under the POUs node
        for pou in pous:
            pou_name = pou['name']
            pou_type = pou['type']
            pou_item = TreeItem([pou_name, pou_type])  # Include name and type
            pous_item.append_child(pou_item)

        # Notify the view that the data has changed
        self.layoutChanged.emit()

