import os
import json
from PyQt6.QtCore import QObject, pyqtProperty, pyqtSlot, pyqtSignal

class ProjectManager(QObject):
    projectOpenChanged = pyqtSignal(bool)

    def __init__(self):
        super().__init__()
        self._project_open = False
        self.project = None
        self.project_path = None

    @pyqtProperty(bool, notify=projectOpenChanged)
    def project_open(self):
        return self._project_open

    @project_open.setter
    def project_open(self, value):
        if self._project_open != value:
            self._project_open = value
            self.projectOpenChanged.emit(value)

    @pyqtSlot(str, str)
    def create_new_project(self, name, path):
        self.project = {
            'name': name,
            'files': []
        }
        self.project_path = os.path.join(path, name)
        os.makedirs(self.project_path, exist_ok=True)
        self.save_project()
        self.project_open = True

    @pyqtSlot(str)
    def open_project(self, path):
        with open(path, 'r') as file:
            self.project = json.load(file)
        self.project_path = os.path.dirname(path)
        self.project_open = True

    @pyqtSlot()
    def close_project(self):
        self.project = None
        self.project_path = None
        self.project_open = False

    def save_project(self):
        if self.project and self.project_path:
            project_file = os.path.join(self.project_path, f"{self.project['name']}.json")
            with open(project_file, 'w') as file:
                json.dump(self.project, file, indent=4)

    @pyqtSlot(str)
    def save_as_project(self, new_path):
        if self.project:
            self.project_path = new_path
            os.makedirs(self.project_path, exist_ok=True)
            self.save_project()

    def _load_from_tc6_xml(self, path):
        tree = ET.parse(path)
        root = tree.getroot()
    
        project_data = {
            'name': root.get('name', 'UnnamedProject'),
            'files': [],
            'plc_config': {
                'variables': [],
                'mappings': [],
                'pous': [],
                'ladder_diagrams': [],
                'structured_texts': []
            }
        }
    
        # Parse variables
        variables = root.find('Variables')
        if variables is not None:
            for var in variables:
                project_data['plc_config']['variables'].append({
                    'name': var.get('name'),
                    'type': var.get('type'),
                    'value': var.get('value')
                })
    
        # Parse mappings
        mappings = root.find('Mappings')
        if mappings is not None:
            for mapping in mappings:
                project_data['plc_config']['mappings'].append({
                    'source': mapping.get('source'),
                    'target': mapping.get('target')
                })
    
        # Parse ladder diagrams
        ladder_diagrams = root.find('LadderDiagrams')
        if ladder_diagrams is not None:
            for ladder in ladder_diagrams.findall('LadderDiagram'):
                rungs = []
                for rung in ladder.findall('Rung'):
                    contacts = [
                        {
                            'type': contact.get('type'),
                            'variable': contact.get('variable')
                        }
                        for contact in rung.findall('Contact')
                    ]
                    coils = [
                        {
                            'type': coil.get('type'),
                            'variable': coil.get('variable')
                        }
                        for coil in rung.findall('Coil')
                    ]
                    rungs.append({'contacts': contacts, 'coils': coils})
                project_data['plc_config']['ladder_diagrams'].append({
                    'name': ladder.get('name'),
                    'rungs': rungs
                })
    
        # Parse structured texts
        structured_texts = root.find('StructuredTexts')
        if structured_texts is not None:
            for st in structured_texts.findall('StructuredText'):
                project_data['plc_config']['structured_texts'].append({
                    'name': st.get('name'),
                    'code': st.text.strip()
                })
    
        return project_data


# Example usage:
# pm = ProjectManager()
# pm.create_new_project('MyProject', '/home/melina/dev/projects')
# pm.save_as_project('/home/melina/dev/new_projects')
# pm.open_project('/home/melina/dev/projects/MyProject/MyProject.json')