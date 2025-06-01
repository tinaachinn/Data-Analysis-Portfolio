#US Household Income Exploratory Data Analysis 

#Identify which state has the biggest land
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

#Identify which state has the most water
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;

SELECT *
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
WHERE MEAN <> 0
;

SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
WHERE MEAN <> 0
;

#checking which state has the highest income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 10
;

#checking which type has the highest income
SELECT Type, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN <> 0
GROUP BY Type
ORDER BY 2 DESC
LIMIT 10
;

#including count as 1 input is too unrealiable vs 100+
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN <> 0
GROUP BY Type
ORDER BY 3 DESC
LIMIT 20
;

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 3 DESC
LIMIT 20
;

SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE MEAN <> 0
GROUP BY u.State_Name, City
ORDER BY 3 DESC;

