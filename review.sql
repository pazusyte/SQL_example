--The movie 'Dune: Part Two' has been delayed from 2023 to 2024. 
UPDATE movies
  SET year = 2024
  WHERE title = 'Dune: Part Two';

--Update the database to represent this fact. You can assume there is only a single movie with this title.
SELECT * FROM movies 
WHERE title = 'Dune: Part Two';

--Who was the director of "The Godfather"? You can assume there is only a single movie with this title.
SELECT name FROM people
INNER JOIN directors ON people.id = directors.person_id
INNER JOIN movies ON directors.movie_id = movies.id
WHERE movies.title = 'The Godfather';

--Find the title and rating of a movie directed by Stanley Kubrick with the lowest rating.

SELECT MIN(rating), movies.title FROM ratings
INNER JOIN directors ON ratings.movie_id = directors.movie_id
INNER JOIN movies ON directors.movie_id = movies.id
WHERE directors.person_id = (SELECT id FROM people WHERE name = 'Stanley Kubrick');

--Count the number of movies that have the word "Potter" in their title. It should ignore words such as "Pottery".
SELECT COUNT(title) FROM movies
WHERE title LIKE '%Potter %'
OR title LIKE '%Potter'
OR title = 'Potter';

--The difference between LEFT and RIGHT JOIN is the order of the tables. LEFT JOIN returns all the records from the left table, and matched records from the right table. RIGHT JOIN returns all records from the right table, and the matched records from the left table. SQLite does not support RIGHT JOIN, but you can use LEFT JOIN instead.
--INNER JOIN gets the records that have matching values in both tables. OUTER JOIN gets all records when there is a match in either the left or the right table.
