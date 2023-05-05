/*
 * Count the number of tweets that use #coronavirus
 */

/*with tag as(
    select data->>'id' AS id_tweets, to_tsvector('simple',COALESCE(data->'entities'->>'hashtags')) AS tag1,
    to_tsvector('simple',COALESCE(data->'extended_tweet'->'entities'->>'hashtags')) AS tag2
    from tweets_jsonb
)
*/
with tag_ids1 as(
    SELECT distinct data->>'id' as id_tweets
    FROM tweets_jsonb
    WHERE (to_tsvector('simple',COALESCE(data->'entities'->'hashtags')) @@ to_tsquery('simple', '#coronavirus'))
), 

tag_ids2 as(
    SELECT distinct data->>'id' as id_tweets
    FROM tweets_jsonb
    WHERE (to_tsvector('simple',COALESCE(data->'extended_tweet'->'entities'->'hashtags')) @@ to_tsquery('simple', '#coronavirus'))
)

select count(distinct id_tweets)
from tag_ids1 a
full outer join  tag_ids2 b using(id_tweets)
where a.id_tweets is null or b.id_tweets is null;
