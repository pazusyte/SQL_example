// Write a Node.js script that takes a movie title and year as a command-line argument.
// Print an error message if a movie with the same title and year already exists in the database.
// If it does not exist, add a new row for the movie and its rating (null rating, 0 votes) to the database.
// If any query fails, roll back your changes.
// If queries succeed, print the new movie ID to the console. Use query parameters.
const betterSqlite3 = require('better-sqlite3');
const process = require('process');

const dbPath = '../movies.db';
const title = process.argv[2];
const year = process.argv[3];

function addMovieToDatabase(title, year) {
  const db = betterSqlite3(dbPath);

  try {
    const getMaxIdQuery = `SELECT MAX(id) as maxId FROM movies`;
    const maxIdRow = db.prepare(getMaxIdQuery).get();
    const newMovieId = (maxIdRow.maxId || 0) + 1;

    const primaryQuery = `
      SELECT *
      FROM movies
      WHERE title = ? AND year = ?
    `;
    const existingMovie = db.prepare(primaryQuery).get(title, year);

    if (existingMovie) {
      console.log('A movie with this title and year already exists');
      return;
    }

    db.exec('BEGIN TRANSACTION');

    const addMovieQuery = `
      INSERT INTO movies (id, title, year)
      VALUES (?, ?, ?)
    `;
    db.prepare(addMovieQuery).run(newMovieId, title, year);

    const addRatingQuery = `
      INSERT INTO ratings (movie_id, rating, votes)
      VALUES (?, '0.0', 0)
    `;
    db.prepare(addRatingQuery).run(newMovieId);

    const confirmIDQuery = `
      SELECT id
      FROM movies
      WHERE title = ? AND year = ?
    `;
    const newMovie = db.prepare(confirmIDQuery).get(title, year);

    db.exec('COMMIT');

    console.log('New movie added with ID:', newMovie.id);
  } catch (err) {
    console.error('Error:', err.message);
    db.exec('ROLLBACK');
  } finally {
    db.close();
    console.log('Database connection closed.');
  }
}

addMovieToDatabase(title, year);
