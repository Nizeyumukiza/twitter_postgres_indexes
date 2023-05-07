/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
with tweet_tags as(
    SELECT distinct(data->>'id') as id_tweets,
    '#' || (jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]') ||
         COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') AS tag
    FROM tweets_jsonb
    WHERE  (COALESCE(data->'entities'->'hashtags','[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))@> '[{"text": "coronavirus"}]'::jsonb
)

SELECT
    tag,
    count(*) as count
FROM tweet_tags
GROUP BY (1)
ORDER BY count DESC,tag
LIMIT 1000;
