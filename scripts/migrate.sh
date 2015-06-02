#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.. 

export PGSERVICE=pg_qgep_sige

psql -c 'DROP SCHEMA IF EXISTS qgep CASCADE';
psql -c 'DROP SCHEMA IF EXISTS sige_assainissement CASCADE';
psql -c 'DROP SCHEMA IF EXISTS sa CASCADE';
${DIR}/QGEP-Datamodel/scripts/db_setup.sh

pg_restore -d qgep_sige ${DIR}/migration/dump_topobase.backup
psql -c 'ALTER SCHEMA sige_assainissement RENAME TO sa' -d qgep_sige

psql -d qgep_sige -f ${DIR}/migration/cover_manhole.sql
