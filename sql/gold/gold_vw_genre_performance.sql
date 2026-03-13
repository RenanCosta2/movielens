CREATE OR REPLACE VIEW movielens_gold.vw_genre_performance AS

SELECT
  genres.genre,
  COUNT(ratings.rating) AS total_ratings,
  ROUND(AVG(ratings.rating), 2) AS avg_rating,
  ROUND(STDDEV(ratings.rating), 2) AS std_rating
FROM
  `ornate-shine-402117.movielens_silver.fact_ratings` AS ratings
JOIN
  `ornate-shine-402117.movielens_silver.dim_movies` AS movies
  ON movies.movie_id = ratings.movie_id
JOIN
  `ornate-shine-402117.movielens_silver.movie_genres` AS movie_genres
  ON movie_genres.movie_id = movies.movie_id
JOIN
  `ornate-shine-402117.movielens_silver.dim_genres` AS genres
  ON genres.genre_id = movie_genres.genre_id 
WHERE
  genres.genre <> '(no genres listed)'
GROUP BY
  genres.genre
ORDER BY
  total_ratings DESC,
  avg_rating DESC