## List all the actors born before 1980
```
SELECT name
FROM main_actors_tbl
WHERE year_of_birth < 1980;
```

```
+-----------------------+
| name                  |
+-----------------------+
| Arnold Schwarzenegger |
| Sigourney Weaver      |
| Christian Bale        |
| Leonardo DiCaprio     |
| Angelina Jolie        |
| Zoe Saldaña           |
+-----------------------+

```
## How many movies did Nolan direct?

```
SELECT COUNT(*) number_of_movies
FROM movies_tbl
WHERE director_id = (
	SELECT id 
	FROM directors_tbl
	WHERE name LIKE "Christopher Nolan"
);
```
```
+------------------+
| number_of_movies |
+------------------+
|                2 |
+------------------+
```

## Among all the movies of James Cameron, how many were female actors?


```
SELECT COUNT(*) number_of_female_actress
FROM movies_tbl m
JOIN movie_actors_tbl ma ON m.id = ma.movie_id 
JOIN main_actors_tbl mac ON ma.main_actor_id = mac.id
WHERE director_id = (
	SELECT id 
	FROM directors_tbl
	WHERE name LIKE "James Cameron"
) AND sex LIKE "F";

```
```
+--------------------------+
| number_of_female_actress |
+--------------------------+
|                        3 |
+--------------------------+
```

## How many directors did Leonardo DiCaprio worked with?

```
SELECT COUNT(DISTINCT(director_id)) number_of_directors
FROM movies_tbl m
JOIN movie_actors_tbl ma ON m.id = ma.movie_id 
JOIN main_actors_tbl mac ON ma.main_actor_id = mac.id
WHERE name LIKE "Leonardo DiCaprio";
```
```
+---------------------+
| number_of_directors |
+---------------------+
|                   2 |
+---------------------+
```
## Who is the oldest director?

```
WITH oldest_director AS
(
	SELECT *
	FROM directors_tbl
	ORDER BY year_of_birth ASC
	LIMIT 1
)
SELECT name 
FROM oldest_director

```
```
+---------------+
| name          |
+---------------+
| James Cameron |
+---------------+
```

## What is the earliest movie of the oldest director ?

```
WITH oldest_director AS
(
	SELECT *
	FROM directors_tbl
	ORDER BY year_of_birth ASC
	LIMIT 1
)

SELECT title 
FROM movies_tbl m
WHERE m.director_id = (
	SELECT id
	FROM oldest_director
)
ORDER BY release_year ASC
LIMIT 1;
```

```
+------------+
| title      |
+------------+
| Terminator |
+------------+
```

## What is the latest movie of the youngest actor?

```
WITH youngest_director AS
(
	SELECT *
	FROM directors_tbl
	ORDER BY year_of_birth DESC 
	LIMIT 1
) 

SELECT title 
FROM movies_tbl m WHERE 
m.director_id = (
	SELECT id
	FROM youngest_director
)
ORDER BY release_year DESC
LIMIT 1;
```
```
+----------+
| title    |
+----------+
| Eternals |
+----------+
```