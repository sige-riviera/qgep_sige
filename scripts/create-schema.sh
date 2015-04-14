
# Exit on error
set -e

PGSERVICE=pg_qgep
psql "service=${PGSERVICE}" -c "DROP SCHEMA IF EXISTS qgep CASCADE"

cd ../../git/scripts

./db_setup.sh

cd ../../sige/scripts

psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1 -f ../fme/before.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1 -f ../fme/before2.sql
psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1 -f ../fme/before3.sql
