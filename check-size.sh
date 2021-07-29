# /bin/sh

docker exec postgres_db_1 bash -c "psql -U rahul -d anomaly -c '\d+'"

# docker exec postgres_db_1 bash -c "psql -U rahul -d anomaly -c 'SELECT pg_size_pretty(pg_total_relation_size(\'anomaly\'))'"
