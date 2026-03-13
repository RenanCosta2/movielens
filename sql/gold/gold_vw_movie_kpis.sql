CREATE OR REPLACE VIEW movielens_gold.vw_movie_kpis AS

WITH ratings_agg AS (
  SELECT
    movie_id,
    COUNT(*) AS total_ratings,
    ROUND(AVG(rating), 2) AS avg_rating,
    STDDEV(rating) AS std_rating,
    MIN(tstamp) AS first_rating,
    MAX(tstamp) AS last_rating
  FROM
    `ornate-shine-402117.movielens_silver.fact_ratings`
  GROUP BY
    movie_id
),

genres_agg AS (
  SELECT
    movie_genres.movie_id,
    STRING_AGG(genres.genre, ', ') AS genres
  FROM
    `ornate-shine-402117.movielens_silver.movie_genres` AS movie_genres
  JOIN
    `ornate-shine-402117.movielens_silver.dim_genres` AS genres
    ON movie_genres.genre_id = genres.genre_id
  GROUP BY
    movie_genres.movie_id
)

SELECT
  movies.movie_id,
  movies.title,
  movies.year,
  genres_agg.genres,
  ratings_agg.total_ratings,
  ratings_agg.avg_rating,
  ratings_agg.std_rating,
  ratings_agg.first_rating,
  ratings_agg.last_rating
FROM
  `ornate-shine-402117.movielens_silver.dim_movies` AS movies
JOIN
  ratings_agg
  ON movies.movie_id = ratings_agg.movie_id
LEFT JOIN
  genres_agg
  ON movies.movie_id = genres_agg.movie_id