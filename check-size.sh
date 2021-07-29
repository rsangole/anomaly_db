# /bin/sh

docker exec postgres_db_1 bash -c "psql -U rahul -d anomaly -c '\d+'"

docker exec postgres_db_1 bash -c "psql -U rahul -d anomaly -c 'SELECT pg_database.datname, pg_size_pretty(pg_database_size(pg_database.datname)) AS size FROM pg_database;'"
