/* 1. Create a query that lists each movie, the film category it is classified in,
and the number of times it has been rented out. */

SELECT distinct f.title film_title, c.name category_name, COUNT(r.rental_id) OVER
(PARTITION BY f.title ORDER BY c.name) rental_count
FROM film f JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
order by 2, 1
