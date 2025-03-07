/*

5. Find the sum of gpd_per_capita by year and the count of countries for each year that have non-null 
gdp_per_capita where (i) the year is before 2012 and (ii) the country has a null gdp_per_capita in 2012. 
Your result should have the columns:

year
country_count
total
*/

--(i) the year is before 2012

SELECT year, COUNT(country_code) AS country_count,CONCAT('$',ROUND(SUM(gdp_per_capita),2)) as total
FROM 'Country Capital'
WHERE NOT gdp_per_capita IS NULL AND year < 2012
GROUP BY year;



--(ii) the country has a null gdp_per_capita in 2012

SELECT year, COUNT(country_code) AS country_count, CONCAT('$',ROUND(SUM(gdp_per_capita),2)) as total
FROM 'Country Capital'
WHERE year = 2012 AND gdp_per_capita IS NULL