SELECT DISTINCT actor.name FROM people
JOIN stars AS kevin ON people.id = kevin.person_id
JOIN stars AS others ON kevin.movie_id = others.movie_id
JOIN people AS actor ON others.person_id = actor.id
WHERE kevin.person_id = (SELECT people.id WHERE people.name = 'Kevin Bacon' AND people.birth = 1958)
AND actor.name != 'Kevin Bacon';
