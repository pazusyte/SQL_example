--List all the movies rated above 8.5 that feature a star born after 2005. 
--Order the list by the movie's rating in descending order. 
--You should return the movie title, rating, and the star's name. 
--A movie can have multiple stars, which means that a movie can appear multiple times in the result set.

SELECT title, ratings.rating, people.name FROM movies
INNER JOIN stars ON movies.id = stars.movie_id
INNER JOIN people ON stars.person_id = people.id
INNER JOIN ratings ON stars.movie_id = ratings.movie_id
WHERE people.birth > 2005
AND ratings.rating > '8.5'
ORDER BY ratings.rating DESC;