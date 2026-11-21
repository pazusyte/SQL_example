//Unfortunately, this database does not include movies released before 1970.
//Write a Node.js script that performs a transaction that inserts the 1957 classic "12 Angry Men",
//associates it with director Sidney Lumet, and sets a 9.0 rating with 834,000 votes.
//You can assume that there is only a single person named Sidney Lumet.
//If there is an error, you should rollback all your operations.

const betterSqlite3 = require('better-sqlite3');

const dbPath = 'movies.db';

const db = betterSqlite3(dbPath);

try {
  const getMaxIdQuery = `SELECT MAX(id) as maxId FROM movies`;
  const maxIdRow = db.prepare(getMaxIdQuery).get();
  const newMovieId = (maxIdRow.maxId || 0) + 1;

  const findDirectorID = `
    SELECT DISTINCT person_id FROM directors
    WHERE person_id = (SELECT id FROM people WHERE name = 'Sidney Lumet')
  `;

  const directorID = db.prepare(findDirectorID).get();

  db.exec('BEGIN TRANSACTION');

  const addMovieQuery = `
      INSERT INTO movies (id, title, year)
      VALUES (?, '12 Angry Men', 1957)
    `;

  db.prepare(addMovieQuery).run(newMovieId);

  const addRatingQuery = `
    INSERT INTO ratings (movie_id, rating, votes)
    VALUES (?, '9.0', 834000)
  `;

  db.prepare(addRatingQuery).run(newMovieId);

  const associateQuery = `
    INSERT INTO directors (movie_id, person_id)
    VALUES (?, ?)
  `;

  db.prepare(associateQuery).run(newMovieId, directorID);

  db.exec('COMMIT');
} catch (err) {
  console.error('Error executing query:', err.message);
  db.exec('ROLLBACK');
} finally {
  db.close();
  console.log('Database connection closed.');
}
```js
import Database from 'better-sqlite3';


const db = new Database('movies.db');


const directorName = 'Sidney Lumet';


const movie = {
  title: '12 Angry Men',
  year: 1957,
};


const rating = {
  rating: 9,
  votes: 834000,
};


const insertMovie = db.transaction((movie, rating, director) => {
  const { id: movieId } = db
    .prepare('INSERT INTO movies (title, year) VALUES (?, ?) RETURNING id')
    .get(movie.title, movie.year);


  db.prepare('INSERT INTO directors (movie_id, person_id) VALUES (?, ?)')
    .run(movieId, director.id);


  db.prepare('INSERT INTO ratings (movie_id, rating, votes) VALUES (?, ?, ?)')
    .run(movieId, rating.rating, rating.votes);


  return movieId;
});


const director = db
  .prepare('SELECT id FROM people WHERE name = ?')
  .get(directorName);


const movieId = insertMovie(movie, rating, director);


console.log('New movie id:', movieId);