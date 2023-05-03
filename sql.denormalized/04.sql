/*
 * Count the number of English tweets containing the word "coronavirus"
 */
SELECT
    count(*)
FROM tweets_jsonb
WHERE to_tsvector('simple',COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('simple','coronavirus')
  AND data->>'lang'='en'
;
