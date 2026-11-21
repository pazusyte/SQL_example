// Write a Node.js script that reads the local .env file to get a FAVORITE_DIRECTOR variable and access the movie database.
// The script should return a list of movies the favorite director directed.
// The list should be ordered by movie rating in descending order.
// Add a local .env file to your project and add the FAVORITE_DIRECTOR variable to it.
require('dotenv').config();
const betterSqlite3 = require('better-sqlite3');

const director = process.env.FAVORITE_DIRECTOR;
const dbPath = '../movies.db';

const db = betterSqlite3(dbPath);

try {
  const query = `
    SELECT movies.title, ratings.rating
    FROM movies
    INNER JOIN directors ON movies.id = directors.movie_id
    INNER JOIN ratings ON movies.id = ratings.movie_id
    WHERE directors.person_id = (SELECT id FROM people WHERE name = ?)
    ORDER BY ratings.rating DESC
  `;

  const statement = db.prepare(query);
  const rows = statement.all(director);

  console.table(rows);
} catch (err) {
  console.error('Error executing query:', err.message);
} finally {
  db.close();
  console.log('Database connection closed.');
}
