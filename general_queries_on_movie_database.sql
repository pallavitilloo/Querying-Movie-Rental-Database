/* Let's start with creating a table that provides the following details:
actor's first and last name combined as full_name,
film title, film description and length of the movie.
How many rows are there in the table? */


SELECT CONCAT(a.first_name,' ',a.last_name) full_name,
f.title, f.description, f.length
FROM
actor a JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON f.film_id = fa.film_id


/* Write a query that creates a list of actors and movies where the movie length
 was more than 60 minutes. How many rows are there in this query result? */

 SELECT CONCAT(a.first_name,' ',a.last_name) full_name,
 f.title, f.length
 FROM
 actor a JOIN film_actor fa
 ON a.actor_id = fa.actor_id
 JOIN film f
 ON f.film_id = fa.film_id
 AND f.length > 60

/* Write a query that captures the actor id, full name of the actor, and counts
the number of movies each actor has made. (HINT: Think about whether you should
group by actor id or the full name of the actor.) Identify the actor who has
made the maximum number movies. */

SELECT CONCAT(a.first_name,' ',a.last_name) full_name,
no_of_films
FROM
actor a JOIN
 (SELECT actor_id, COUNT(film_id) no_of_films
 FROM film_actor GROUP BY actor_id) fa
ON a.actor_id = fa.actor_id
ORDER BY no_of_films DESC



/* Write a query that displays a table with 4 columns: actor's full name, film
title, length of movie, and a column name "filmlen_groups" that classifies
movies based on their length. Filmlen_groups should include 4 categories:
1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours. */


SELECT CONCAT(a.first_name,' ',a.last_name) full_name,
f.title, f.length, CASE
	WHEN f.length <= 60 THEN '< 1 hour'
	WHEN f.length > 60 AND f.length <= 120 THEN '1-2 hours'
	WHEN f.length > 120 AND f.length <= 180 THEN '2-3 hours'
	ELSE '> 3 hours' END
	AS filmlen_groups
 FROM
 actor a JOIN film_actor fa
 ON a.actor_id = fa.actor_id
 JOIN film f
 ON f.film_id = fa.film_id
ORDER BY title



/* Revise the query you wrote above to create a count of movies in each of the
4 filmlen_groups: 1 hour or less, Between 1-2 hours, Between 2-3 hours,
More than 3 hours. */

SELECT COUNT(film_id), CASE
	WHEN length <= 60 THEN '< 1 hour'
	WHEN length > 60 AND length <= 120 THEN '1-2 hours'
	WHEN length > 120 AND length <= 180 THEN '2-3 hours'
	ELSE '> 3 hours' END
	AS filmlen_groups
 FROM film
GROUP BY 2 
