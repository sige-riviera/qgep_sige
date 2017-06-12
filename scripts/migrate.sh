#!/bin/bash
# Préfix to be ordered here : http://www.interlis.ch/oid/oid_commande_f.php
OIDPREFIX="ch176dc9"

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

# Service to be defined in PG_SERVICE.conf file
PGSERVICE=pg_qgep_poc

while getopts ":p:" opt; do
  case $opt in
    p)
      PGSERVICE=$OPTARG
      echo "-p was triggered, PGSERVICE: $PGSERVICE" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# Reframe option to get to MN95 srs. ! Does not work on windows yet!
#psql "service=${PGSERVICE}" -c 'CREATE EXTENSION IF NOT EXISTS fineltra'
psql "service=${PGSERVICE}" -c 'DROP SCHEMA IF EXISTS qgep CASCADE'
#psql "service=${PGSERVICE}" -c 'DROP SCHEMA IF EXISTS sige_assainissement CASCADE'
#psql "service=${PGSERVICE}" -c 'DROP SCHEMA IF EXISTS sa CASCADE'

# Initialize datamodel
${DIR}/datamodel/scripts/db_setup.sh -p $PGSERVICE

# Organisation prefix activation
#Ajout de sigip
psql "service=${PGSERVICE}" -c "INSERT INTO qgep.is_oid_prefixes (prefix,organization,active) VALUES ('ch176dc9','Sigip',FALSE);"
psql "service=${PGSERVICE}" -c "UPDATE qgep.is_oid_prefixes SET active=TRUE WHERE prefix='${OIDPREFIX}'"
psql "service=${PGSERVICE}" -c "UPDATE qgep.is_oid_prefixes SET active=FALSE WHERE prefix<>'${OIDPREFIX}'"

# Option to restore from backup.
#PGSERVICE=${PGSERVICE} pg_restore --no-owner -d ${PGSERVICE} ${DIR}/migration/dump_topobase_95.backup
#psql "service=${PGSERVICE}" -c 'ALTER SCHEMA sige_assainissement RENAME TO sa'

# Function first last
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/aggregates_first_last.sql

# Mappings
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hierarchic.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hierarchic_leitungen.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/reach_horizontal_positioning.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/manhole_function.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/special_structure_function.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/usage_current.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/status.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/reach_material.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/reach_material_leitungen.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/elevation_determination.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hydraulic.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hydraulic_leitungen.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/access_aid_kind.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/structure_type.sql

# Migration
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/organisations.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/wastewater_structure_cover.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/profiles.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/reach_channel.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/reach_channel_leitungen.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/prank_weir.sql

# Recreate views
#psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/90_create_topology.sql
#psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1  -f ${DIR}/datamodel/07_views_for_network_tracking.sql # not sure why we need to rerun this one

# Change owner
PGSERVICE=${PGSERVICE} OWNER=qgep SCHEMA=qgep DATABASE=qgep_poc ${DIR}/datamodel/scripts/change_owner.sh
