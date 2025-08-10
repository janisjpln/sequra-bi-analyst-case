-- Q1.1: Find countries with more than 3 customers
-- Business Goal:
-- Identify main markets with a solid user base for targeted campaigns or feature prioritization.
-- Logic:
-- 1. Group customers by country
-- 2. Count customers and calculate average age
-- 3. Filter countries with >3 customers
-- 4. Sort by count descending

SELECT 
  country,
  COUNT(*) AS customer_count,
  ROUND(AVG(age), 1) AS average_age
FROM 
  `sequra-challenge-2025.sequra_challenge.customers`
GROUP BY 
  country
HAVING 
  COUNT(*) > 3
ORDER BY 
  customer_count DESC;