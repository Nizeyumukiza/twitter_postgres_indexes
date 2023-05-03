/*
 * Count the number of tweets that use #coronavirus
 */

/*with tag as(
    select data->>'id' AS id_tweets, to_tsvector('simple',COALESCE(data->'entities'->>'hashtags')) AS tag1,
    to_tsvector('simple',COALESCE(data->'extended_tweet'->'entities'->>'hashtags')) AS tag2
    from tweets_jsonb
)
*/
SELECT count(distinct data->>'id')
FROM tweets_jsonb
WHERE (to_tsvector('simple',COALESCE(data->'entities'->>'hashtags')) @@ to_tsquery('simple', '#coronavirus'))
    OR (to_tsvector('simple',COALESCE(data->'extended_tweet'->'entities'->>'hashtags')) @@ to_tsquery('simple', '#coronavirus'));
