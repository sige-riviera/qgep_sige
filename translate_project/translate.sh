/home/drouzaud/opt/QGIS2/build/output/bin/qgis /home/drouzaud/Documents/QGEP/sige/translate_project/translate.qgs
sed -i -r 's/^(\s*<attributeEditorRelation .*?)relation=""(.*)name="(.*?)"(.*?)$/\1 relation="\3"\2name="\3"\4/g' /home/drouzaud/Documents/QGEP/sige/qgis-project/qgep_sige_auto.qgs
/home/drouzaud/opt/QGIS2/build/output/bin/qgis /home/drouzaud/Documents/QGEP/sige/qgis-project/qgep_sige_auto.qgs &

