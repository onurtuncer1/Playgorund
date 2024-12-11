import sys
from pathlib import Path

# Add 'src' directory (one level up) to sys.path
src_path = Path(__file__).resolve().parent.parent / 'src'
sys.path.append(str(src_path))

# Import the class
from ProjectManager import ProjectManager

pm = ProjectManager()

# Load project with ladder and ST file
pm.open_project("../sampleProject/plc.xml")

# Access ladder diagram
for ladder in pm.project['plc_config']['ladder_diagrams']:
    print(f"Ladder: {ladder['name']}, Rungs: {len(ladder['rungs'])}")

# Access ST code
for st in pm.project['plc_config']['structured_texts']:
    print(f"ST POU: {st['name']}, Code:\n{st['code']}")