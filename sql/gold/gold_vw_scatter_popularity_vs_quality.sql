CREATE OR REPLACE VIEW movielens_gold.vw_scatter_popularity_vs_quality AS 

SELECT
  movie_id,
  title,
  genres,
  year,
  total_ratings,
  avg_rating
FROM
  `ornate-shine-402117.movielens_gold.vw_movie_kpis`
WHERE
  total_ratings >= 50