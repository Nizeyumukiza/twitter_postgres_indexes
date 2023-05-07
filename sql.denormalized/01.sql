/*
 * Count the number of tweets that use #coronavirus
 */

SELECT count(DISTINCT(data->>'id'))
FROM tweets_jsonb
WHERE (COALESCE(data->'entities'->'hashtags','[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')) @> '[{"text": "coronavirus"}]'::jsonb;

