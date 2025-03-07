/*
 For the year 2012, create a 3 column, 1 row report showing the percent share of gdp_per_capita for the following regions:

(i) Asia, (ii) Europe, (iii) the Rest of the World.
*/

WITH join_tables AS (
    SELECT c3.code as continent_code, gdp_per_capita as growth, CASE
        WHEN c3.code = 'AS' THEN 'Asia'
        WHEN C3.code = 'EU' THEN 'Europe'
        ELSE 'Rest of World'
    END AS region
    FROM "Country Capital" c
    JOIN ContinentMap c2 ON c.country_code = c2.country_code
    JOIN Continent c3 ON c2.continent_code = c3.code
    WHERE c.year = 2012
),total_growth AS (
    SELECT SUM(growth) AS total_growth
    FROM join_tables
), region_growth AS (
   SELECT region, CONCAT(ROUND(SUM(growth) / (SELECT * FROM total_growth),2),'%') AS percent_region_growth
   FROM join_tables
    GROUP BY region 
)




SELECT *
FROM region_growth



