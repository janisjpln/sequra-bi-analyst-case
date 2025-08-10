-- Q1.2: Monthly ticket value trend for 2024
-- Business Goal:
-- Understand monthly variations in total sales to identify seasonal trends 
-- and detect growth or decline patterns throughout the year.
--
-- Logic:
-- 1. Join orders with order_items to get ticket values.
-- 2. Filter only orders from 2024.
-- 3. Calculate monthly total sales amount.
-- 4. Use LAG() to compare with the previous month.
-- 5. Calculate month-over-month growth percentage.
-- 6. Order results chronologically.
--
-- Assumptions:
-- - Ticket value = quantity * unit_price for each order item.
-- - Month-over-month growth formula:
--      ((current_month - previous_month) / previous_month) * 100
-- - Months with no previous data have NULL growth.

WITH monthly_sales AS (
  SELECT
    FORMAT_DATE('%Y-%m', o.order_date) AS month,
    SUM(oi.quantity * oi.unit_price) AS total_amount
  FROM
    `sequra-challenge-2025.sequra_challenge.orders` o
  JOIN
    `sequra-challenge-2025.sequra_challenge.order_items` oi
    ON o.order_id = oi.order_id
  WHERE
    EXTRACT(YEAR FROM o.order_date) = 2024
  GROUP BY
    month
)
SELECT
  month,
  total_amount,
  ROUND(
    ( (total_amount - LAG(total_amount) OVER (ORDER BY month)) 
      / LAG(total_amount) OVER (ORDER BY month) ) * 100, 
    2
  ) AS mom_growth_percentage
FROM
  monthly_sales
ORDER BY
  month;