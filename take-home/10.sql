--In 2023, Christopher Nolan and Greta Gerwig each released a new movie. 
--These movies already exist in the database, but they have no ratings. 
--Write a single query to add a rating to one of these movies. 
--For these movies, you can assume there is only one movie with the same title and year in the database.

INSERT INTO ratings (movie_id, rating, votes)
SELECT movies.id, '10.0', 1 FROM movies
INNER JOIN directors ON movies.id = directors.movie_id
INNER JOIN people ON directors.person_id = people.id 
WHERE people.name = 'Christopher Nolan'
AND movies.year = 2023;