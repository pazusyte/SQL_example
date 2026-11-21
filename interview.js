const betterSqlite3 = require('better-sqlite3');
const fs = require('fs');

const dbPath = 'movies.db';
const director = fs.readFileSync('director.txt', 'utf8');

const query = `SELECT name, COUNT(name) AS counts FROM people
JOIN stars ON people.id = stars.person_id
WHERE stars.movie_id IN (SELECT movie_id FROM directors
WHERE person_id = (SELECT id FROM people WHERE name = ?))
GROUP BY name
ORDER BY counts DESC`;

const db = betterSqlite3(dbPath);

try {
  const statement = db.prepare(query);
  const rows = statement.all(director);
  console.table(rows);
} catch (err) {
  console.error('Error executing query:', err.message);
} finally {
  db.close();
}
