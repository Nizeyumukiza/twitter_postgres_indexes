/*
 * Setting up cores and memory for optimal indexing
 */
\set max_parallel_maintenance_workers to 70
\set maintenance_work_mem to '16GB'

BEGIN;
/*
 * Creating indexes to optimize querying
 */

CREATE INDEX on tweet_tags(tag, id_tweets);
CREATE INDEX on tweets(id_tweets, lang);
CREATE INDEX on tweets using gin(to_tsvector('english', text));
CREATE INDEX on tweets(lang);
CREATE INDEX on tweet_tags(id_tweets);

COMMIT;
