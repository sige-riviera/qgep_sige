/usr/bin/pg_dump --host 172.24.171.203 --port 5432 --username "sige" --no-password  --format plain --inserts --column-inserts --verbose --file "/home/drouzaud/Documents/QGEP/sige/migration/dump_topobase.sql" --schema "sige_assainissement" "topobase_dump"
zip -9r /home/drouzaud/Documents/QGEP/sige/migration/dump_topobase_sql.zip /home/drouzaud/Documents/QGEP/sige/migration/dump_topobase.sql
rm /home/drouzaud/Documents/QGEP/sige/migration/dump_topobase.sql

/usr/bin/pg_dump --host 172.24.171.203 --port 5432 --username "sige" --no-password  --format custom --blobs --verbose --file "/home/drouzaud/Documents/QGEP/sige/migration/dump_topobase.backup" --schema "sige_assainissement" "topobase_dump"

git add dump_topobase.sql dump_topobase_sql.zip
git commit -m "updated topobase dump"
git push

