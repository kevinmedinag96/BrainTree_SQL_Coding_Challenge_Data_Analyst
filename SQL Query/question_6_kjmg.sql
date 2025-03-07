/*

6. All in a single query, execute all of the steps below and provide the results as your final answer:

a. create a single list of all per_capita records for year 2009 that includes columns:

continent_name
country_code
country_name
gdp_per_capita

b. order this list by:

continent_name ascending
characters 2 through 4 (inclusive) of the country_name descending
c. create a running total of gdp_per_capita by continent_name

d. return only the first record from the ordered list for which each continent's running total of gdp_per_capita meets or exceeds $70,000.00 with the following columns:

continent_name
country_code
country_name
gdp_per_capita
running_total

*/

SELECT c3.name AS continent_name, c.country_code as country_code, c2.name AS country_name, 
c.gdp_per_capita AS gdp_per_capita, SUM(c.gdp_per_capita) AS running_total
FROM 'Country Capital' c
JOIN ContinentMap m ON c.country_code = m.country_code
JOIN Country c2 ON c.country_code = c2.code
JOIN Continent c3 ON m.continent_code = c3.code
WHERE year = 2009
GROUP BY c3.name
HAVING SUM(c.gdp_per_capita) >= 70000
ORDER BY continent_name, SUBSTR(country_name,2,4) DESC


/*
Answer :
Africa,AGO,Angola,3988.683557,117970.1345942
Asia,AFG,Afghanistan,450.659239,534788.067672
Europe,AND,Andorra,0.0,1382875.768183
"North America",ABW,Aruba,24639.93533,405923.8890288
Oceania,AUS,Australia,42721.88494,103764.59827
"South America",ARG,Argentina,7674.342976,74829.452371
sqlite> .read "SQL Query/question_6_kjmg.sql"
Africa,AGO,Angola,3988.683557,117970.1345942
Asia,AFG,Afghanistan,450.659239,534788.067672
Europe,AND,Andorra,0.0,1382875.768183
"North America",ABW,Aruba,24639.93533,405923.8890288
Oceania,AUS,Australia,42721.88494,103764.59827
"South America",ARG,Argentina,7674.342976,74829.452371
*/