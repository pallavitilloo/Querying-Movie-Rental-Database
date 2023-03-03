/* Write a query that returns the store ID for the store, the year and month and
 the number of rental orders each store has fulfilled for that month. Your table
 should include a column for each of the following: year, month, store ID and
 count of rental orders fulfilled during that month. */

 WITH store_monthly AS
(SELECT DATE_PART('month', r.rental_date) rental_month,
DATE_PART('year', r.rental_date) rental_year, s.store_id
FROM
store s JOIN staff st
ON s.store_id = st.store_id
JOIN rental r
ON r.staff_id = st.staff_id),

data AS (SELECT CONCAT(mon_desc,' ',rental_year) AS month_year, store_id, 			count_rentals
 FROM (SELECT CASE WHEN rental_month = 1 THEN 'Jan'
      WHEN rental_month = 2 THEN 'Feb'
            WHEN rental_month = 3 THEN 'Mar'
            WHEN rental_month = 4 THEN 'Apr'
            WHEN rental_month = 5 THEN 'May'
            WHEN rental_month = 6 THEN 'Jun'
            WHEN rental_month = 7 THEN 'Jul'
            WHEN rental_month = 8 THEN 'Aug'
            WHEN rental_month = 9 THEN 'Sep'
            WHEN rental_month = 10 THEN 'Oct'
            WHEN rental_month = 11 THEN 'Nov'
            WHEN rental_month = 12 THEN 'Dec'
            END AS mon_desc, rental_year, store_id, COUNT(*) count_rentals
   FROM store_monthly
   GROUP BY 1, 2, 3) sub)

SELECT sub1.month_year, store_1, store_2
FROM
(SELECT month_year, count_rentals AS store_1
 FROM data
 WHERE store_id = 1) sub1
JOIN
(SELECT month_year, count_rentals AS store_2
   FROM data WHERE store_id = 2) sub2
ON sub1.month_year = sub2.month_year
