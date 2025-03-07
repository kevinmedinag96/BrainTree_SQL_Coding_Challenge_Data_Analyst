/*
4a. What is the count of countries and sum of their related gdp_per_capita values for the year 2007 
where the string 'an' (case insensitive) appears anywhere in the country name?
*/

/*
SELECT COUNT(*) AS count_countries, CONCAT('$',ROUND(SUM(c.gdp_per_capita),2)) as sum_gdp_countries
FROM 'Country Capital' c
JOIN Country c2 ON c.country_code = c2.code
WHERE c.year = 2007 AND c2.name REGEXP '.*[Aa][nN].*'

*/

/*
4b. Repeat question 4a, but this time make the query case sensitive.
*/

SELECT COUNT(*) AS count_countries, CONCAT('$',ROUND(SUM(c.gdp_per_capita),2)) as sum_gdp_countries
FROM 'Country Capital' c
JOIN Country c2 ON c.country_code = c2.code
WHERE c.year = 2007 AND c2.name REGEXP '.*an.*'
LIMIT 10