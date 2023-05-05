/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
with tweet_dtags as(
    select data->>'id' AS id_tweets, to_tsvector('simple',COALESCE(data->'entities'->'hashtags')) AS tag1,
    to_tsvector('simple',COALESCE(data->'extended_tweet'->'entities'->'hashtags')) AS tag2
    from tweets_jsonb
),

dtweets as(
    select data->>'id' as id_tweets, data->>'lang' as lang,
    to_tsvector('simple',COALESCE(data->'extended_tweet'->>'full_text',data->>'text')) as    vtext
    from tweets_jsonb
)

SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT
        id_tweets,
        tag
    FROM dtweets
    JOIN tweet_tags USING (id_tweets)
    WHERE vtext @@ to_tsquery('simple','coronavirus')
      AND lang='en'
) t
GROUP BY tag
ORDER BY count DESC,tag
LIMIT 1000
;


