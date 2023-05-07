/*
 * Calculates the languages that use the hashtag #coronavirus
 */

SELECT
    data->>'lang' as lang,
    count(DISTINCT data->>'id') as count
FROM tweets_jsonb
WHERE (COALESCE(data->'entities'->'hashtags','[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')) @> '[{"text": "coronavirus"}]'::jsonb
GROUP BY data->>'lang'
ORDER BY count DESC,data->>'lang';
