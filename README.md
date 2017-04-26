# qgep_sigip

1. To run the migration set your pg conf files according to your postgres connexion

Ex :

.pg_service.conf

```
#qgep 
[pg_qgep]
#database ip
host=postgisxxxxxxx.pully.ch
#database name
dbname=qgep
port=5432
user=postgres
password=YOURPOSTGRESPASSWORD
```

2. Set the mappings files according to your matching

in `migration/mappings/*.sql`

3. Adapt and run the migration bash script :

`scripts/migrate.sh`
