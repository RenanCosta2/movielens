CREATE OR REPLACE VIEW movielens_gold.vw_ratings_heatmap AS 

SELECT
  EXTRACT(YEAR FROM tstamp) AS year,
  EXTRAdocker rmiCT(MONTH FROM tstamp) AS month_number,
  FORMAT_TIMESTAMP('%b', tstamp) AS month_name,
  COUNT(*) AS total_ratings
FROM
  `ornate-shine-402117.movielens_silver.fact_ratings` AS ratings
GROUP BY
  year,
  month_number,
  month_name
ORDER BY
  year,
  month_number