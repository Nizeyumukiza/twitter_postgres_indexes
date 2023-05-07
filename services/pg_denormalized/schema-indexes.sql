/*
 * Setting up cores and memory for optimal indexing
 */
\set max_parallel_maintenance_workers to 70
\set maintenance_work_mem to '16GB'

 
BEGIN;
CREATE EXTENSION pg_trgm;

CREATE INDEX on tweets_jsonb((data->>'id'));
CREATE INDEX ON tweets_jsonb((data->>'lang'));
CREATE INDEX tweets_jsonb_fts_idx ON tweets_jsonb USING gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text')));
CREATE INDEX  ON tweets_jsonb USING GIN(
  (COALESCE(data->'entities'->'hashtags','[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')) jsonb_path_ops
);

COMMIT;
