
/* 2. Can you provide a table with the movie titles and divide them into 4
levels (first_quarter, second_quarter, third_quarter, and final_quarter) based
on the quartiles (25%, 50%, 75%) of the rental duration for movies across all
categories? Make sure to also indicate the category that these family-friendly
movies fall into. */


SELECT f.title, c.name category, f.rental_duration,
NTILE(4) OVER (PARTITION BY f.rental_duration) AS standard_quartile
FROM
film f JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
WHERE c.name IN ('Animation', 'Children', 'Classics',
'Comedy', 'Family', 'Music')
