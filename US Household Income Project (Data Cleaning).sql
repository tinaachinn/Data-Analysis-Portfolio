#US Household Income Data Cleaning 

ALTER TABLE us_household_income_statistics
RENAME COLUMN `ï»¿id` TO `id`;

#Checking on duplicates
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id 
HAVING COUNT(id) > 1
;

#Identifying the Row_ID of the duplicates
SELECT *
FROM (
	SELECT row_id,
    id,
    ROW_NUMBER() OVER( PARTITION BY id ORDER BY id) as Row_Num
    FROM us_household_income
    ) AS duplicates
WHERE Row_Num > 1
;

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as Row_Num
		FROM us_household_income
		) AS duplicates
	WHERE Row_Num > 1)
    ;

#check any mispelled country
SELECT State_Name, COUNT(State_Name)
FROM us_household_income
GROUP BY State_Name;

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

SELECT *
FROM us_household_income
WHERE Place = ''
;

SELECT * 
FROM us_household_income
WHERE City = 'Vinemont'
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;