CREATE OR REPLACE VIEW movielens_gold.vw_user_activity AS 

SELECT
  user_id,
  COUNT(*) AS total_ratings,
  COUNT(DISTINCT movie_id) AS movies_rated,
  AVG(rating) AS avg_rating,
  STDDEV(rating) AS std_rating,
  MIN(tstamp) AS first_rating,
  MAX(tstamp) AS last_rating
FROM
  `ornate-shine-402117.movielens_silver.fact_ratings` AS ratings
GROUP BY
  user_id
ORDER BY
  total_ratings DESC,
  avg_rating DESC