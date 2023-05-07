/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
with result as(
    SELECT distinct(data->>'id') as id_tweets, '#' || (jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text') AS tag
    FROM tweets_jsonb
    WHERE (to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text')) @@ to_tsquery('english', 'coronavirus'))
  AND data->>'lang'='en'
    GROUP BY id_tweets, tag
)

select tag, count(id_tweets)
from result
GROUP BY tag
ORDER BY count DESC,tag
LIMIT 1000;
