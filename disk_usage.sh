docker-compose exec pg_denormalized sh -c 'du -hd0 $PGDATA'
docker-compose exec pg_normalized_batch sh -c 'du -hd0 $PGDATA'
