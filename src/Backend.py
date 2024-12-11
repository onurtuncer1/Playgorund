from PyQt6.QtCore import QObject, pyqtSlot, pyqtSignal, pyqtProperty


class Backend(QObject):
    companyNameChanged = pyqtSignal(str)
    productNameChanged = pyqtSignal(str)
    productVersionChanged = pyqtSignal(str)

    def __init__(self):
        super().__init__()
        self._companyName = ""
        self._productName = ""
        self._productVersion = ""

    # QML Bindable Properties
    @pyqtProperty(str, notify=companyNameChanged)
    def companyName(self):
        return self._companyName

    @companyName.setter
    def companyName(self, value):
        if self._companyName != value:
            self._companyName = value
            self.companyNameChanged.emit(value)

    @pyqtProperty(str, notify=productNameChanged)
    def productName(self):
        return self._productName

    @productName.setter
    def productName(self, value):
        if self._productName != value:
            self._productName = value
            self.productNameChanged.emit(value)

    @pyqtProperty(str, notify=productVersionChanged)
    def productVersion(self):
        return self._productVersion

    @productVersion.setter
    def productVersion(self, value):
        if self._productVersion != value:
            self._productVersion = value
            self.productVersionChanged.emit(value)

    @pyqtSlot(str)
    def saveToXml(self, fileUrl):
        """Save data to an XML file."""
        file_path = fileUrl.replace("file:///", "")

        # Access QML properties directly
        companyName = self.companyName
        productName = self.productName
        productVersion = self.productVersion

        if not companyName or not productName or not productVersion:
            print("Error: Please fill in all fields.")
            return

        # (Serialization logic remains the same)

    @pyqtSlot(str)
    def loadFromXml(self, fileUrl):
        """Load data from an XML file."""
        file_path = fileUrl.replace("file:///", "")
        if os.path.exists(file_path):
            # (Deserialization logic remains the same)

            # Update QML properties
            self.companyName = companyName
            self.productName = productName
            self.productVersion = productVersion



