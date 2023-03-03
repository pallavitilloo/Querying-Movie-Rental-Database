/* Which country's customers are placing the highest number of orders in the store? */

/* We will join the required tables rental, customer, city and country and
get the top 10 countries with highest rental counts. */

SELECT co.country, COUNT(rental_id)
FROM rental r JOIN customer c
ON r.customer_id = c.customer_id
JOIN address a
ON c.address_id = a.address_id
JOIN city cy
ON a.city_id = cy.city_id
JOIN country co
ON cy.country_id = co.country_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
