./output/bin/qgis /home/drouzaud/Documents/QGEP/sige/translate_project/translate.qgs &
sleep 15 # wait for QGIS to finish
sed -i -r 's/^(\s*<attributeEditorRelation .*?)relation=""(.*)name="(.*?)"(.*?)$/\1 relation="\3"\2name="\3"\4/g' /home/drouzaud/Documents/QGEP/sige/qgis-project/qgep_sige_auto.qgs