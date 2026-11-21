--Count the number of movie titles that start with word 'Rifftrax'
SELECT COUNT(title) FROM movies
WHERE title LIKE 'Rifftrax%';

--How old was the director of 'Goodfellas' at the time of movie's release?
--(Find the difference between movie's release year and director's birth year).
SELECT movies.year - birth FROM people 
JOIN directors ON people.id = directors.person_id
JOIN movies ON directors.movie_id = movies.id
WHERE movies.title = 'Goodfellas';

--List movies title and their release year that were directed by Christopher McQuarrie and starred Tom Cruise. 
--List movies from newest to oldest.

SELECT title, year FROM movies
INNER JOIN directors ON movies.id = directors.movie_id
INNER JOIN stars ON directors.movie_id = stars.movie_id
WHERE directors.person_id = (SELECT id FROM people WHERE name = 'Christopher McQuarrie')
AND stars.person_id = (SELECT id FROM people WHERE name = 'Tom Cruise')
ORDER BY year DESC;

--In a director.txt file write a name of your favorite director.
--Write a node.js script that would list actors names who starred in directors movies
--and how many times they appeared. Order the list by the number of times they appeared in descending order.

--Christopher Nolan

SELECT name, COUNT(name) AS counts FROM people
JOIN stars ON people.id = stars.person_id
WHERE stars.movie_id IN (SELECT movie_id FROM directors
WHERE person_id = (SELECT id FROM people WHERE name = 'Christopher Nolan'))
GROUP BY name
ORDER BY counts DESC;