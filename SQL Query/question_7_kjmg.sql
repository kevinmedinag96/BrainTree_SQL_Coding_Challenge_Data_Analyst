/*
7. Find the country with the highest average gdp_per_capita for each continent for all years. 
Now compare your list to the following data set. Please describe any and all mistakes that you can find with 
the data set below. Include any code that you use to help detect these mistakes.
*/
WITH average_gdp AS (
SELECT c3.name as continent_name, c.country_code as country_code, c2.name as country_name,
AVG(c.gdp_per_capita) as avg_gdp_per_capita, ROW_NUMBER() OVER (PARTITION BY c3.name ORDER BY AVG(c.gdp_per_capita) DESC) AS rank
FROM 'Country Capital' c
JOIN ContinentMap m ON c.country_code = m.country_code
JOIN Country c2 ON c.country_code = c2.code
JOIN Continent c3 ON m.continent_code = c3.code 
GROUP BY c3.name, c2.name  
)

SELECT *
FROM average_gdp
WHERE rank = 1


