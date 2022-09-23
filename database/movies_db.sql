# Create a new database
CREATE DATABASE movie_db;

# Show all databases
SHOW DATABASES;

# Use our new database
USE movie_db;

# Show existing tables
SHOW TABLES;

# Create table directors
CREATE TABLE directors_tbl(
	id int NOT NULL AUTO_INCREMENT,
	name varchar(255),
	year_of_birth int,
	PRIMARY KEY (id)
);

# Get information about table
DESCRIBE directors_tbl;

INSERT INTO directors_tbl VALUES(
	null,
	"James Cameron",
	1970
);

INSERT INTO directors_tbl VALUES(
	null,
	"Christopher Nolan",
	1970
);

INSERT INTO directors_tbl VALUES(
	null,
	"Patty Jenkins",
	1971
);

INSERT INTO directors_tbl VALUES(
	null,
	"Chloe Zhaos",
	1982
);

# Show all data from the table
SELECT	* FROM directors_tbl;	

# Create table movies
CREATE TABLE movies_tbl(
	id int NOT NULL AUTO_INCREMENT,
	title varchar(255),
	release_year int,
	director_id int NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (director_id) REFERENCES directors_tbl(id)
);

# Add new movie to Movies table
INSERT INTO movies_tbl VALUES(
	null,
	"Titanic",
	1997,
	(SELECT id FROM directors_tbl WHERE name LIKE "James Cameron")	
);

# Add new movies as a list to Movies table
INSERT INTO movies_tbl VALUES
	(null,
	"Aliens",
	1986,
	(SELECT id FROM directors_tbl WHERE name LIKE "James Cameron")),

	(null,
	"Wonder Women",
	2017,
	(SELECT id FROM directors_tbl WHERE name LIKE "Patty Jenkins")),

	(null,
	"Avatar",
	2009,
	(SELECT id FROM directors_tbl WHERE name LIKE "James Cameron")),

	(null,
	"Inception",
	2010,
	(SELECT id FROM directors_tbl WHERE name LIKE "Christopher Nolan")),

	(null,
	"Terminator",
	1984,
	(SELECT id FROM directors_tbl WHERE name LIKE "James Cameron")),

	(null,
	"Cleopatra",
	2023,
	(SELECT id FROM directors_tbl WHERE name LIKE "Patty Jenkins")),

	(null,
	"Eternals",
	2021,
	(SELECT id FROM directors_tbl WHERE name LIKE "Chloe Zhaos")),

	(null,
	"The Dark Knight",
	2008,
	(SELECT id FROM directors_tbl WHERE name LIKE "Christopher Nolan"))
;

# Selecting from multiple tables	
SELECT *
FROM movies_tbl JOIN  directors_tbl ON movies_tbl.director_id = directors_tbl.id
WHERE movies_tbl.title LIKE "Inception";

# Update an existing data in the table
UPDATE directors_tbl
SET name = 'James Cameron'
WHERE id = 1;

# Create table for actors
CREATE TABLE main_actors_tbl(
	id int NOT NULL AUTO_INCREMENT,
	name varchar(255),
	year_of_birth int,
	sex varchar(1),
	PRIMARY KEY (id)
);

INSERT INTO main_actors_tbl VALUES
(null, "Arnold Schwarzenegger", 1947, "M"),
(null, "Gal Gadot", 1985, "F"),
(null, "Sigourney Weaver", 1949, "F"),
(null, "Christian Bale", 1974, "M"),
(null, "Leonardo DiCaprio", 1974, "M"),
(null, "Angelina Jolie", 1975, "F"),
(null, "Zoe Saldaña", 1978, "F"),
(null, "Gemma Chan", 1982, "F")
;

# Create your Movie-Actors table
CREATE TABLE movie_actors_tbl(
    movie_id int NOT NULL,
    main_actor_id int NOT NULL,
    PRIMARY KEY (movie_id, main_actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies_tbl(id),
    FOREIGN KEY (main_actor_id) REFERENCES main_actors_tbl(id)
);

INSERT INTO movie_actors_tbl VALUES
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Avatar"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Zoe Saldaña")
);

INSERT INTO movie_actors_tbl VALUES
(
	(SELECT id FROM movies_tbl WHERE title LIKE "The Dark Knight"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Christian Bale")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Inception"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Leonardo DiCaprio")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Eternals"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Angelina Jolie")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Aliens"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Sigourney Weaver")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Cleopatra"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Gal Gadot")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Eternals"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Gemma Chan")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Titanic"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Leonardo DiCaprio")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Wonder Women"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Gal Gadot")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Terminator"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Arnold Schwarzenegger")
),
(
	(SELECT id FROM movies_tbl WHERE title LIKE "Avatar"),
	(SELECT id FROM main_actors_tbl WHERE name LIKE "Sigourney Weaver")
);

SELECT movies_tbl.title, main_actors_tbl.name
FROM movies_tbl
	JOIN movie_actors_tbl ON movies_tbl.id = movie_actors_tbl.movie_id
	JOIN main_actors_tbl ON main_actors_tbl.id = movie_actors_tbl.main_actor_id
WHERE movies_tbl.title LIKE "Avatar";
;
SELECT movies_tbl.title, main_actors_tbl.name
FROM movies_tbl
	JOIN movie_actors_tbl ON movies_tbl.id = movie_actors_tbl.movie_id
	JOIN main_actors_tbl ON main_actors_tbl.id = movie_actors_tbl.main_actor_id
WHERE movies_tbl.title LIKE "Avatar";


SELECT COUNT(*)
FROM movies_tbl
WHERE title LIKE "T%";

SELECT *
FROM movies_tbl
ORDER BY release_year ASC;

