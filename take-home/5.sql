--List star names and the number of movies they have appeared in (acted). List only the stars that have appeared in at least 300 movies.
SELECT name, COUNT(stars.movie_id) FROM people
JOIN stars ON people.id = stars.person_id
GROUP BY name
HAVING COUNT(stars.movie_id) >= 300;