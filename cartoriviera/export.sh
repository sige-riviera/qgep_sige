#!/bin/bash

set -e

export PGSERVICE=qgep_prod
psql -c "DROP TABLE IF EXISTS qgep_export.export_reach"
psql -c "DROP TABLE IF EXISTS qgep_export.export_wastewater_structure"
psql -c "CREATE TABLE qgep_export.export_reach AS SELECT * FROM qgep_export.vw_export_reach;"
psql -c "CREATE TABLE qgep_export.export_wastewater_structure AS SELECT * FROM qgep_export.vw_export_wastewater_structure;"



# dump export schema
/usr/bin/pg_dump --host 172.24.173.216 --port 5432 --username "sige" --no-password  --format plain --column-inserts --verbose --file "qgep_cartoriviera.sql" --table "qgep_export.export_wastewater_structure" --table "qgep_export.export_reach" "qgep_prod"
#/usr/bin/pg_dump --host 172.24.173.216 --port 5432 --username "sige" --no-password  --format custom --blobs --verbose --file "qgep_cartoriviera.backup" --schema "qgep_export_tables" --table "qgep_export_tables.export_wastewater_structure" --table "qgep_export_tables.export_reach" "qgep_prod"

export PGSERVICE=chenyx

# import in chenyx DB
psql -c "DROP SCHEMA IF EXISTS qgep_export CASCADE"
psql -c "CREATE SCHEMA qgep_export;"
psql -v ON_ERROR_STOP=1 -f qgep_cartoriviera.sql


# transform
psql -c "ALTER TABLE qgep_export.export_reach                ALTER COLUMN progression_geometry TYPE Geometry(CompoundCurveZ, 21781) USING ST_GeomFromEWKB(ST_Fineltra(progression_geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));"
psql -c "ALTER TABLE qgep_export.export_wastewater_structure ALTER COLUMN situation_geometry   TYPE Geometry(MultiPoint, 21781)     USING ST_GeomFromEWKB(ST_Fineltra(situation_geometry,   'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));"


/usr/bin/pg_dump --host 172.24.171.203 --port 5432 --username "sige" --no-password  --format plain --verbose --file "qgep_cartoriviera.sql" --schema "qgep_export" "chenyx"



# FTP UPLOAD
PASS=`cat /home/drouzaud/ftp_pass_carto`
ftp -n -v ftp.vevey.ch <<-EOF
user carto_sige $PASS
prompt
binary
cd QGIS_server
put qgep_cartoriviera.sql qgep_cartoriviera.sql
put export.qgs export.qgs
bye
EOF
