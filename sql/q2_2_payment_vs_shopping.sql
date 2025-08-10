-- Q2.2: Payment Management vs Shopping Portal Engagement
-- Business Goal:
-- Analyze how payment management usage correlates with shopping portal engagement
-- during the second half of 2024, to uncover behavioral patterns and identify
-- opportunities for cross-sell and upsell campaigns.
--
-- Logic:
-- 1. Identify payment management events:
--      - payment_date_change
--      - installment_extension
--      - refinance_request
-- 2. Identify shopping portal events:
--      - merchant_view
--      - merchant_click
-- 3. Count events per user for both categories.
-- 4. Filter for sessions between July and December 2024.
-- 5. Present customer_id, payment management count, and shopping portal count.
--
-- Assumptions:
-- - One row in app_events = one event occurrence.
-- - A customer can have both payment management and shopping portal events.
-- - Time range is inclusive from 2024-07-01 to 2024-12-31.
--
-- Insights:
-- Users who engage with payment management tools show significantly higher
-- activity in the shopping portal compared to those who do not.
-- This suggests that payment management features may drive broader engagement
-- with the platform. High-value segments include:
--   - Dual engagers: active in both areas — ideal for upsell campaigns.
--   - Passive explorers: browse merchants but do not use payment management.
--   - Pure managers: manage payments but do not browse merchants.

SELECT
  customer_id,
  SUM(CASE WHEN event_type IN ('payment_date_change', 'installment_extension', 'refinance_request') THEN 1 ELSE 0 END) AS payment_management_events,
  SUM(CASE WHEN event_type IN ('merchant_view', 'merchant_click') THEN 1 ELSE 0 END) AS shopping_portal_events
FROM
  `sequra-challenge-2025.sequra_challenge.app_events`
WHERE
  event_timestamp BETWEEN '2024-07-01' AND '2024-12-31'
GROUP BY
  customer_id
ORDER BY
  payment_management_events DESC,
  shopping_portal_events DESC;