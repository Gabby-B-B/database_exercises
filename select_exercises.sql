USE albums_db;
SELECT database ();
SHOW tables;
DESCRIBE albums;
# The name of all albums by Pink Floyd
SELECT name as 'Pink Floyd Albums'
FROM albums WHERE artist = 'Pink Floyd';
# The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date as 'Year Released'
FROM albums
WHERE name LIKE 'Sgt%';
# The genre for the album Nevermind
SELECT genre FROM albums  WHERE name LIKE 'NEVER%';
# Which albums were released in the 1990s
SELECT * FROM albums
WHERE release_date >= '1990'
AND release_date <= '1999';
# Which albums had less than 20 million certified sales
SELECT * FROM albums
WHERE sales < '20.0';
# All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT * FROM albums 
WHERE genre = 'rock';
#These results do not include hard rock or progressive rock because they are their own queries. Therefore a wildcard is needed to find all types of rock in one query.
SELECT * FROM albums
WHERE genre LIKE '%rock%';