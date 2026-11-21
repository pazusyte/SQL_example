--Count all the times that Martin Scorsese directed.
SELECT COUNT(movie_id) FROM directors
LEFT JOIN people ON directors.person_id = people.id
WHERE people.name = 'Martin Scorsese';