#!/bin/bash
OIDPREFIX="ch15z36d"

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

PGSERVICE=qgep_demo

while getopts ":p:" opt; do
  case $opt in
    s)
      PGSERVICE=$OPTARG
      echo "-p was triggered, PGSERVICE: $PGSERVICE" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


psql "service=${PGSERVICE}" -c 'CREATE EXTENSION IF NOT EXISTS fineltra'
psql "service=${PGSERVICE}" -c 'DROP SCHEMA IF EXISTS qgep CASCADE'
psql "service=${PGSERVICE}" -c 'DROP SCHEMA IF EXISTS sige_assainissement CASCADE'
psql "service=${PGSERVICE}" -c 'DROP SCHEMA IF EXISTS sa CASCADE'
${DIR}/datamodel/scripts/db_setup.sh -s 2056 -p $PGSERVICE

psql "service=${PGSERVICE}" -c "UPDATE qgep.is_oid_prefixes SET active=TRUE WHERE prefix='${OIDPREFIX}'"
psql "service=${PGSERVICE}" -c "UPDATE qgep.is_oid_prefixes SET active=FALSE WHERE prefix<>'${OIDPREFIX}'"

PGSERVICE=${PGSERVICE} pg_restore --no-owner -d ${PGSERVICE} ${DIR}/migration/dump_topobase_95.backup
psql "service=${PGSERVICE}" -c 'ALTER SCHEMA sige_assainissement RENAME TO sa'

psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/aggregates_first_last.sql

psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hierarchic.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/reach_horizontal_positioning.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/manhole_function.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/usage_current.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/status.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/reach_material.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/elevation_determination.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hydraulic.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/access_aid_kind.sql

psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/organisations.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/cover_manhole.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/profiles.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/reach_channel.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/prank_weir.sql

psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1  -f ${DIR}/datamodel/07_views_for_network_tracking.sql # not sure why we need to rerun this one
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=on -f ${DIR}/migration/90_create_topology.sql

OWNER=qgep SCHEMA=qgep DATABASE=${PGSERVICE} ${DIR}/datamodel/scripts/change_owner.sh
