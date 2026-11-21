--List the names of the 10 oldest people and how many years have passed since they were born in the current year. 
--Do not include people who do not have a birth year.
SELECT name, (2024 - birth) FROM people
WHERE birth NOT NULL
ORDER BY birth
LIMIT 10;