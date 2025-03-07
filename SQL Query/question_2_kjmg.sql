/*
List the countries ranked 10-12 in each continent by the percent of year-over-year growth descending from 2011 to 2012.

The percent of growth should be calculated as: ((2012 gdp - 2011 gdp) / 2011 gdp)

The list should include the columns:

* rank
* continent_name
* country_code
* country_name
* growth_percent
*/

WITH join_tables AS (
SELECT c3.name as continent_name, c2.code as country_code, c2.name as country_name, c.gdp_per_capita as growth,
LEAD(c.gdp_per_capita,1,NULL) OVER (PARTITION BY c.country_code ORDER BY c.year) as next_year_growth
FROM "Country Capital" c
JOIN Country c2
ON c.country_code = c2.code
JOIN ContinentMap m
ON c.country_code = m.country_code
JOIN Continent c3
ON m.continent_code = c3.code
WHERE c.year IN (2011,2012)  
), growth_cte AS (
    SELECT *, ROUND(100.0 * ((next_year_growth - growth) / (growth)),2) AS percent_growth
    FROM join_tables
    WHERE NOT next_year_growth IS NULL
), rank_in_continent AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY continent_name ORDER BY percent_growth DESC) AS rank
    FROM growth_cte

)

SELECT rank, continent_name, country_code, country_name, CONCAT(percent_growth,'%') as percent_growth
FROM rank_in_continent
WHERE rank BETWEEN 10 AND 12

/*
Answer:
* rank  continent_name country_code country_name growth_percent
10,Africa,RWA,Rwanda,8.73%
11,Africa,GIN,Guinea,8.32%
12,Africa,NGA,Nigeria,8.09%
10,Asia,UZB,Uzbekistan,11.12%
11,Asia,IRQ,Iraq,10.06%
12,Asia,PHL,Philippines,9.73%
10,Europe,MNE,Montenegro,-2.93%
11,Europe,SWE,Sweden,-3.02%
12,Europe,ISL,Iceland,-3.84%
10,"North America",GTM,Guatemala,2.71%
11,"North America",HND,Honduras,2.71%
12,"North America",ATG,"Antigua and Barbuda",2.52%
10,Oceania,FJI,Fiji,3.29%
11,Oceania,TUV,Tuvalu,1.27%
12,Oceania,KIR,Kiribati,0.04%
10,"South America",ARG,Argentina,5.67%
11,"South America",PRY,Paraguay,-3.62%
12,"South America",BRA,Brazil,-9.83%
*/