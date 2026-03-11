CREATE OR REPLACE TABLE movielens_silver.movie_genres AS

WITH movies_transformed AS (
  SELECT 
    movieId, 
    SPLIT(genres, '|') AS genres_array
  FROM 
    `ornate-shine-402117.movielens_bronze.movies` 
),

movie_genres AS (
  SELECT DISTINCT
    CAST(movieId AS INT64) AS movie_id,
    dim_genres.genre_id
  FROM
    movies_transformed,
    UNNEST(genres_array) AS genre
  LEFT JOIN
    movielens_silver.dim_genres
    ON genre = dim_genres.genre
)

SELECT * FROM movie_genres

