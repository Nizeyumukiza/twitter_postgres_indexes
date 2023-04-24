/*
 * Setting up cores and memory for optimal indexing
 */
\set max_parallel_maintenance_workers to 70
\set maintenance_work_mem to '16GB'

BEGIN;
/*
 * turn the views into tables
 */

/*SELECT * INTO tweets from tweets;
SELECT * INTO tweet_tags from tweet_tags;
*/ 
 /*
 * Creating indexes to optimize querying
 */

CREATE INDEX on tweet_tags(tag, id_tweets);
CREATE INDEX on tweets(id_tweets, lang);
CREATE INDEX on tweets using gin(to_tsvector('english', text));
CREATE INDEX on tweets(lang);

COMMIT;
