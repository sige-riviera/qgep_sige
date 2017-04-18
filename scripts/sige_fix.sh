



psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1 -c " \
DROP VIEW qgep.vw_qgep_maintenance; \
DROP VIEW qgep.vw_maintenance_examination; \
ALTER TABLE qgep.od_maintenance_event ALTER COLUMN base_data TYPE text; \
$(/home/drouzaud/Documents/QGEP/sige/datamodel/view/vw_maintenance_examination.py ${PGSERVICE})"
