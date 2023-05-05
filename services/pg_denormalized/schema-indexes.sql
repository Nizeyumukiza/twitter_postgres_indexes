/*
 * Setting up cores and memory for optimal indexing
 */
\set max_parallel_maintenance_workers to 70
\set maintenance_work_mem to '16GB'


BEGIN;
CREATE TEXT SEARCH CONFIGURATION simple (COPY = simple);    
 
BEGIN;

CREATE INDEX on tweets_jsonb((data->>'id'));
CREATE INDEX on tweets_jsonb using gin(to_tsvector('simple',COALESCE(data->'entities'->'hashtags')));
CREATE INDEX on tweets_jsonb using gin(to_tsvector('simple', COALESCE(data->'extended_tweet'->'entities'->'hashtags'))); 
CREATE INDEX ON tweets_jsonb((data->>'lang'));
CREATE INDEX ON tweets_jsonb using gin(to_tsvector('simple',COALESCE(data->'extended_tweet'->>'full_text',data->>'text')));

COMMIT;
