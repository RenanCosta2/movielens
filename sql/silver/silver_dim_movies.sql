CREATE OR REPLACE TABLE movielens_silver.dim_movies AS

SELECT 
  movieId AS movie_id, 
  REGEXP_REPLACE(title, r'\((\d{4})\)', '') AS title,
  REGEXP_EXTRACT(title, r'\((\d{4})\)') AS year
FROM 
  `ornate-shine-402117.movielens_bronze.movies` AS movies