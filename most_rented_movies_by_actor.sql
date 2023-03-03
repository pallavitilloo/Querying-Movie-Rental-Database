/* Which actor's movies have been rented the most? */

WITH actor_info AS
  (SELECT COUNT(r.rental_id) rental_count, a.actor_id
  FROM
  actor a JOIN film_actor fa
  ON a.actor_id = fa.actor_id
  JOIN film f
  ON fa.film_id = f.film_id
  JOIN inventory i
  ON f.film_id = i.film_id
  JOIN rental r
  ON i.inventory_id = r.inventory_id
  GROUP BY 2)

SELECT CONCAT(a.first_name,' ',a.last_name) as full_name,
rental_count
FROM actor_info ai JOIN actor a
ON ai.actor_id = a.actor_id
ORDER BY 2 DESC
