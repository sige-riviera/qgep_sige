#!/bin/bash

OIDPREFIX="ch15z36d"

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

export PGSERVICE=pg_qgep_sige

psql -c 'DROP SCHEMA IF EXISTS qgep CASCADE'
psql -c 'DROP SCHEMA IF EXISTS sige_assainissement CASCADE'
psql -c 'DROP SCHEMA IF EXISTS sa CASCADE'
${DIR}/datamodel/scripts/db_setup.sh

psql -c "UPDATE qgep.is_oid_prefixes SET active=TRUE WHERE prefix='${OIDPREFIX}'"
psql -c "UPDATE qgep.is_oid_prefixes SET active=FALSE WHERE prefix<>'${OIDPREFIX}'"

pg_restore --no-owner -d qgep_sige ${DIR}/migration/dump_topobase.backup
psql -c 'ALTER SCHEMA sige_assainissement RENAME TO sa'

psql -v ON_ERROR_STOP=on -f ${DIR}/migration/aggregates_first_last.sql

psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hierarchic.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/reach_horizontal_positioning.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/manhole_function.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/usage_current.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/status.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/reach_material.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/elevation_determination.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/function_hydraulic.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/mappings/access_aid_kind.sql

psql -v ON_ERROR_STOP=on -f ${DIR}/migration/organisations.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/cover_manhole.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/profiles.sql
psql -v ON_ERROR_STOP=on -f ${DIR}/migration/reach_channel.sql

psql -v ON_ERROR_STOP=on -f ${DIR}/migration/90_create_topology.sql

OWNER=qgep SCHEMA=qgep DATABASE=qgep_sige ${DIR}/datamodel/scripts/change_owner.sh
