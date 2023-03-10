--This will drop the table should in case it was already created
DROP TABLE IF EXISTS albums_tracks CASCADE;
DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS tracks;

--Creating the tables
CREATE TABLE albums (
    album_ID int NOT NULL,
    title text NOT NULL,
    artist Varchar (100) NOT NULL,
    PRIMARY KEY (album_ID)
);

CREATE TABLE tracks (
    track_ID int NOT NULL,
    title text NOT NULL,
    artist Varchar (100) NOT NULL,
    length_min TIME NOT NULL,
    PRIMARY KEY (track_ID)
);

--Inserting the rows into the albums table
INSERT INTO albums (album_ID,title,artist)
VALUES (1,'Goodbye & Good Riddance','Juice WRLD'),
       (2,'Me vs Myself','A Boogie with da hoodie'),
       (3,'Please Excuse Me For Being Antisocial','Roddy Ricch'),
       (4,'Dying to Live','Kodack Black'),
       (5,'Hoodie SZN','A Boogie with da hoodie'),
       (6,'DRFL','Juice WRLD'),
       (7,'THE GOAT','Polo G'),
       (8,'Legends Never Die','Juice WRLD'),
       (9,'The Party Never Ends','Juice WRLD'),
       (10,'Hall of Fame 2.0','Polo G');

--Inserting the rows into the tracks table
INSERT INTO tracks (track_ID,title,artist,length_min)
VALUES (1,'February','A boogie with da hoodie','2:34'),
       (2,'Turn Off The Radio','A boogie with da hoodie','3:05'),
       (3,'Blood On My Jeans','Juice WRLD','2:33'),
       (4,'MoshPit','Kodak Black','2:44'),
       (5,'Fast','Juice WRLD','3:28'),
       (6,'Black & White','Juice WRLD','3:07'),
       (7,'21','Polo G','2:44'),
       (8,'High Fashion','Roddy Ricch','3:41'),
       (9,'Just Like Me','A boogie with da hoodie','3:41'),
       (10,'Bad Man','Polo G','1:45');

--Creating a linking table
CREATE TABLE albums_tracks (
    id serial PRIMARY KEY,
    album_ID integer REFERENCES albums(album_ID),
    track_ID integer REFERENCES tracks(track_ID)
);

--Inserting the rows into the linking table
INSERT INTO albums_tracks (album_ID,track_ID)
VALUES (1,6),
       (2,1),
       (2,2),
       (3,8),
       (4,4),
       (5,9),
       (6,5),
       (7,7),
       (8,3),
       (10,10);

--Write an SQL query to see the albums and the tracks that belong to that album.
SELECT A.title, T.title, T.length_min
FROM albums AS A
INNER JOIN albums_tracks AS AT
ON A.album_ID = AT.album_ID
INNER JOIN tracks AS T
ON AT.track_ID = T.track_ID;

--Write an SQL query to see the album or albums that each track belongs to
SELECT T.title AS track_name, T.length_min AS track_length, A.title AS released_on_album
FROM tracks as T
INNER JOIN albums_tracks AS AT
ON T.track_ID = AT.track_ID
INNER JOIN albums AS A
ON AT.album_ID = A.album_ID;

--Write a query to see the number of songs an album has.
SELECT A.title AS album_title, COUNT(T.track_ID)
FROM albums AS A
FULL JOIN albums_tracks AS AT
ON A.album_ID = AT.album_ID
FULL JOIN tracks AS T
ON AT.track_ID = T.track_ID
GROUP BY A.album_ID;

--Write a query to see how many albums a particular track is included on.
SELECT T.title AS tracks_title, COUNT (A.album_ID)
FROM albums AS A
FULL JOIN albums_tracks AS AT
ON A.album_ID = AT.album_ID
FULL JOIN tracks AS T
ON AT.track_ID = T.track_ID
WHERE T.title = 'February'
GROUP BY  T.track_ID;
