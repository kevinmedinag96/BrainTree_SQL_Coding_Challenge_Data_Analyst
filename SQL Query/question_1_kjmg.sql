/*
Data Integrity Checking and Cleanup:

1.- Alphabetically list all of the country codes in the continent_map table that appear more than once. 
Display any values where country_code is null as country_code = "FOO" and make this row appear first in the list, 
even though it should alphabetically sort to the middle. Provide the results of this query as your answer.

*/


/*
SELECT 
    COALESCE(country_code, 'FOO') AS country_code
FROM
    ContinentMap
GROUP BY country_code
HAVING COUNT(*) > 1
ORDER BY country_code;
*/


/*
2.- For all countries that have multiple rows in the continent_map table, 
delete all multiple records leaving only the 1 record per country. 
The record that you keep should be the first one when sorted by the continent_code alphabetically ascending. 
Provide the query/ies and explanation of step(s) that you follow to delete these records.


STEPS:
Create ctes to partition the data based on country and ordered by continent, assign rows to each record.
Delete rows that meet the specified criteria
*/


CREATE TABLE tmp_table_1 AS
    SELECT country_code,continent_code, ROW_NUMBER() OVER (PARTITION BY country_code ORDER BY continent_code) AS row_country
    FROM ContinentMap;

CREATE TABLE tmp_table_2 AS
    SELECT row_country
    FROM tmp_table_1
    WHERE row_country = 1;

DELETE FROM tmp_table_1 WHERE NOT row_country IN (SELECT row_country FROM tmp_table_2);

DELETE FROM ContinentMap;

INSERT INTO ContinentMap 
    SELECT country_code, continent_code 
    FROM tmp_table_1;

DROP TABLE tmp_table_1;
DROP Table tmp_table_2;



