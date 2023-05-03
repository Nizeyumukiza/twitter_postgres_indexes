/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
with tweet_dtags as(
    select data->>'id' AS id_tweets, to_tsvector('simple',COALESCE(data->'entities'->>'hashtags')) AS tag1,
    to_tsvector('simple',COALESCE(data->'extended_tweet'->'entities'->>'hashtags')) AS tag2
    from tweets_jsonb
)

SELECT
    tag,
    count(*) as count
FROM (
    SELECT DISTINCT
        id_tweets,
        t2.tag
    FROM tweet_dtags t1
    JOIN tweet_tags t2 USING (id_tweets)
    WHERE t1.tag1 @@ to_tsquery('simple','#coronavirus')
    OR t1.tag2 @@ to_tsquery('simple','#coronavirus')
) t
GROUP BY (1) 
ORDER BY count DESC,tag
LIMIT 1000;
