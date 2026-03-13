CREATE OR REPLACE VIEW movielens_gold.vw_top_movies AS 

SELECT
  movie_id,
  title,
  year,
  total_ratings,
  avg_rating
FROM
  `ornate-shine-402117.movielens_gold.vw_movie_kpis`
WHERE
  total_ratings >= 20
ORDER BY
  avg_rating DESC,
  total_ratings DESC
LIMIT 10