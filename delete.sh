docker-compose exec pg_denormalized bash -c 'rm -rf $PGDATA'
docker-compose exec pg_normalized_batch bash -c 'rm -rf $PGDATA'
