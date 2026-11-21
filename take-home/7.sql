--Write a query that lists all movie titles where Scarlett Johansson and Chris Evans starred together.
SELECT title FROM movies
INNER JOIN stars ON movies.id = stars.movie_id
INNER JOIN people ON stars.person_id = people.id
WHERE people.name IN ('Scarlett Johansson', 'Chris Evans')
GROUP BY title
HAVING COUNT(people.name) = 2;

