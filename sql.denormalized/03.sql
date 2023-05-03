/*
 * Calculates the languages that use the hashtag #coronavirus
 */
with tweet_dtags as(
    select data->>'id' AS id_tweets, to_tsvector('simple',COALESCE(data->'entities'->>'hashtags')) AS tag1,
    to_tsvector('simple',COALESCE(data->'extended_tweet'->'entities'->>'hashtags')) AS tag2
    from tweets_jsonb
),

dtweets as(
    select data->>'id' as id_tweets, data->>'lang' as lang
    from tweets_jsonb
)


SELECT
    lang,
    count(DISTINCT id_tweets) as count
FROM tweet_dtags t1
JOIN dtweets USING (id_tweets)
WHERE t1.tag1 @@ to_tsquery('simple','#coronavirus')
    OR t1.tag2 @@ to_tsquery('simple','#coronavirus')
GROUP BY lang
ORDER BY count DESC,lang;
