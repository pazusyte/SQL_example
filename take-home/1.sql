--Count all movie titles released between 2005 and 2015.
SELECT COUNT(title)
FROM movies
WHERE 2005 < year < 2015;