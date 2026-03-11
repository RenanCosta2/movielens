CREATE OR REPLACE TABLE movielens_silver.dim_genres AS

WITH movies_transformed AS (
  SELECT 
    SPLIT(genres, '|') AS genres_array
  FROM `ornate-shine-402117.movielens_bronze.movies`
),

genres AS (
  SELECT DISTINCT
    genre
  FROM movies_transformed,
  UNNEST(genres_array) AS genre
)

SELECT
  ROW_NUMBER() OVER (ORDER BY genre) AS genre_id,
  genre
FROM genres