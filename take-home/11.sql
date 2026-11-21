--Do starting letters correlate with the average movie rating? 
--List movie title starting letters and an average rating associated with them. 
--Ignore non-Latin and non-uppercase letters.

SELECT SUBSTR(title,1,1), AVG(ratings.rating) FROM movies
INNER JOIN ratings ON movies.id = ratings.movie_id
WHERE title REGEXP '^[A-Z]'
GROUP BY SUBSTR(title,1,1);
