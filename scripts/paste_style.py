style_file = "styles/qgep.style"
layer_ids = ['vw_qgep_reach', 'vw_qgep_wastewater_structure']

from qgis.PyQt.QtXml import QDomDocument
from qgis.PyQt.QtCore import QFile, QTextStream
from qgis.PyQt.QtGui import QApplication

errMsg = ''
path = QgsProject.instance().homePath() + '/' + style_file
file = QFile(path)
file.open(QFile.ReadOnly | QFile.Text)
doc = QDomDocument()
doc.setContent(file)
root = doc.elementsByTagName('qgis.custom.style')
nodes = root.at(0).childNodes()
for i in range(0,nodes.count()):
    elem = nodes.at(i).toElement()
    if elem.tagName() != 'layer' or not elem.hasAttribute('id'):
        continue
    layer_id = elem.attribute('id')
    if layer_id not in layer_ids:
        print 'skipping ', layer_id
    layer = QgsMapLayerRegistry.instance().mapLayer(layer_id)
    if not layer:
        print 'layer not found', layer_id
        continue
    print 'loading', layer_id
    style = elem.firstChild()
    style.removeChild(style.firstChildElement('edittypes'))
    layer.readStyle(style, errMsg)
