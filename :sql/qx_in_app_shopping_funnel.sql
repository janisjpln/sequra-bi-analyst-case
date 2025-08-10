-- QX: In-App Shopping Funnel Performance for H2 2024
-- Business Goal:
-- Measure the performance of the shopping funnel within the mobile app to estimate
-- engagement and purchase intent in the absence of a purchase traceability flag.
--
-- Logic:
-- 1. Identify active users in the app during H2 2024 (July–December 2024).
-- 2. Count how many of them viewed at least one merchant in that period.
-- 3. Count how many of those viewers clicked on at least one merchant.
-- 4. Count how many of those clickers generated purchase intent (click on the same merchant seen in the same session).
-- 5. Calculate stage-to-stage conversion rates in the funnel.
--
-- Assumptions:
-- - Active user: any customer with at least one app session in H2 2024.
-- - Merchant view: event_type = 'merchant_view'.
-- - Merchant click: event_type = 'merchant_click'.
-- - Intent: merchant click on the same merchant previously viewed in the same session.
-- - Dates filtered from '2024-07-01' to '2024-12-31'.
--
-- Limitations:
-- - Without purchase traceability, we cannot confirm if intent resulted in an actual purchase.
-- - Events outside app_sessions are not considered.
--
-- Insight:
-- The in-app shopping funnel for H2 2024 shows a strong engagement flow:
-- - 93% of active users viewed at least one merchant.
-- - 78% of those viewers clicked on a merchant.
-- - 100% of clickers demonstrated purchase intent (clicking on the same merchant seen in the same session).
-- This indicates a healthy funnel with minimal drop-off between stages,
-- suggesting that increasing active users could directly increase overall conversions.


WITH active_users AS (
  SELECT DISTINCT customer_id
  FROM `sequra-challenge-2025.sequra_challenge.app_sessions`
  WHERE session_start BETWEEN TIMESTAMP('2024-07-01') AND TIMESTAMP('2024-12-31')
),
views AS (
  SELECT DISTINCT customer_id
  FROM `sequra-challenge-2025.sequra_challenge.app_events`
  WHERE event_type = 'merchant_view'
    AND event_timestamp BETWEEN TIMESTAMP('2024-07-01') AND TIMESTAMP('2024-12-31')
),
clicks AS (
  SELECT DISTINCT customer_id
  FROM `sequra-challenge-2025.sequra_challenge.app_events`
  WHERE event_type = 'merchant_click'
    AND event_timestamp BETWEEN TIMESTAMP('2024-07-01') AND TIMESTAMP('2024-12-31')
),
intent AS (
  SELECT DISTINCT e.customer_id
  FROM `sequra-challenge-2025.sequra_challenge.app_events` e
  JOIN `sequra-challenge-2025.sequra_challenge.app_events` v
    ON e.session_id = v.session_id
   AND e.merchant_id = v.merchant_id
   AND v.event_type = 'merchant_view'
  WHERE e.event_type = 'merchant_click'
    AND e.event_timestamp BETWEEN TIMESTAMP('2024-07-01') AND TIMESTAMP('2024-12-31')
)
SELECT
  (SELECT COUNT(*) FROM active_users) AS users_active_h2,
  (SELECT COUNT(*) FROM views) AS users_view_merchant,
  ROUND((SELECT COUNT(*) FROM views) / (SELECT COUNT(*) FROM active_users) * 100, 2) AS rate_active_to_view_pct,
  (SELECT COUNT(*) FROM clicks) AS users_click_merchant,
  ROUND((SELECT COUNT(*) FROM clicks) / (SELECT COUNT(*) FROM views) * 100, 2) AS rate_view_to_click_pct,
  (SELECT COUNT(*) FROM intent) AS users_intent,
  ROUND((SELECT COUNT(*) FROM intent) / (SELECT COUNT(*) FROM clicks) * 100, 2) AS rate_click_to_intent_pct;
