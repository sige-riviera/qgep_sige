
# Exit on error
set -e

PGSERVICE=pg_qgep


psql "service=${PGSERVICE}" -v ON_ERROR_STOP=1 -f ../fme/after.sql

