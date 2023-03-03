/* We would like to know who were our top 10 paying customers, how many payments
 they made on a monthly basis during 2007, and what was the amount of the
 monthly payments. Can you write a query to capture the customer name,
 month and year of payment, and total payment amount for each month by these
  top 10 paying customers?*/

  WITH top_10 AS(SELECT distinct CONCAT(c.first_name,' ', c.last_name) full_name, c.customer_id,
  SUM(p.amount) OVER(PARTITION BY CONCAT(c.first_name,' ', c.last_name))
  FROM
  customer c JOIN payment p
  ON c.customer_id = p.customer_id
  WHERE DATE_PART('year', p.payment_date) = '2007'
  ORDER BY sum DESC
  LIMIT 10)

  SELECT CASE WHEN date_part = 1 THEN 'January'
              WHEN date_part = 2 THEN 'February'
              WHEN date_part = 3 THEN 'March'
              WHEN date_part = 4 THEN 'April'
              WHEN date_part = 5 THEN 'May'
              WHEN date_part = 6 THEN 'June'
              WHEN date_part = 7 THEN 'July'
              WHEN date_part = 8 THEN 'August'
              WHEN date_part = 9 THEN 'September'
              WHEN date_part = 10 THEN 'October'
              WHEN date_part = 11 THEN 'November'
              WHEN date_part = 12 THEN 'December'
              END AS payment_date, full_name, pay_countpermon, pay_amount
  FROM (SELECT distinct 				DATE_TRUNC('month',p.payment_date),DATE_PART('month',p.payment_date), CONCAT(c.first_name,' ',
    c.last_name) full_name,
    COUNT(p.amount) OVER (PARTITION BY p.customer_id,
      DATE_PART('month',p.payment_date)) AS pay_countpermon,
      SUM(p.amount) OVER (PARTITION BY p.customer_id,
        DATE_PART('month',p.payment_date)) AS pay_amount
  	FROM payment p JOIN customer c
      ON p.customer_id = c.customer_id
  	WHERE p.customer_id IN(SELECT customer_id FROM top_10)
  	AND DATE_PART('year',p.payment_date) = '2007') sub
  ORDER BY 2, 4
