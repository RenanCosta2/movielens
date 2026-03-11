CREATE OR REPLACE TABLE movielens_silver.fact_ratings AS 

WITH rating_history AS(
  SELECT
    *
  FROM
    `ornate-shine-402117.movielens_bronze.user_rating_history`

  UNION ALL

  SELECT
    *
  FROM
    `ornate-shine-402117.movielens_bronze.ratings_for_additional_users`
),

ratings_final AS (
  SELECT
    SAFE_CAST(userId AS INT64) AS user_id,
    SAFE_CAST(movieId AS INT64) AS movie_id,
    SAFE_CAST(rating AS FLOAT64) AS rating,
    SAFE_CAST(tstamp AS TIMESTAMP) AS tstamp
  FROM
    rating_history
)

SELECT
  *
FROM
  ratings_final
WHERE
  rating IS NOT NULL AND
  rating <> -1
