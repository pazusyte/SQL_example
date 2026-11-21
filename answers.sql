--1
SELECT title, (year - 3) FROM movies
ORDER BY year DESC
LIMIT 10;
--2
SELECT title, year FROM movies
WHERE title LIKE ('Star Wars%')
AND year < 2024
ORDER BY year;
--3
SELECT name,birth FROM people 
WHERE birth BETWEEN 1974 AND 1978
AND birth <> 1976
LIMIT 50 OFFSET 40;
--4
DELETE FROM movies
WHERE year > 2024;
--5
select ROUND(AVG(rating),2) from ratings
INNER JOIN directors ON ratings.movie_id = directors.movie_id
INNER JOIN people ON directors.person_id = people.id
WHERE people.name = 'Christopher Nolan';
--6
SELECT people.name, COUNT(movie_id) FROM directors
JOIN people ON directors.person_id = people.id
GROUP BY people.name
HAVING COUNT(movie_id) > 100;
--7
SELECT DISTINCT title FROM movies
INNER JOIN stars ON movies.id = stars.movie_id
WHERE stars.movie_id IN 
(SELECT stars.movie_id FROM stars WHERE stars.person_id = (SELECT id FROM people WHERE name = 'Johnny Depp')
INTERSECT
SELECT stars.movie_id FROM stars WHERE stars.person_id = (SELECT id FROM people WHERE name = 'Helena Bonham Carter'));
--8
ALTER TABLE people
RENAME COLUMN birth TO birth_year;
--9
--Callback functions allow to specify what should happen when the database operation completes and doesn't block the execution of other code. 
--They allow to structurize database operations and ensure that certain code runs only after the database operation completes.
--They also provide error handling.
--10
SELECT title FROM movies
INNER JOIN ratings ON movies.id = ratings.movie_id
INNER JOIN stars ON ratings.movie_id = stars.movie_id
INNER JOIN people ON stars.person_id = people.id
WHERE ratings.rating > (SELECT AVG(rating) FROM ratings)
AND people.id = (SELECT id FROM people WHERE name = 'Zendaya');
--11
SELECT title, year FROM movies
WHERE release_year = 2010
ORDER BY title
LIMIT 20 OFFSET 40
--12
--Database migrations are used to alter the database schema.
--Transactions are used to group multiple database operations that need to be executed off the back of eachother.
--Transactions usually operate on a smaller scope, while database migrations can affect the whole database.
--Transactions can be executed by the application code while database migrations are executed by developers.