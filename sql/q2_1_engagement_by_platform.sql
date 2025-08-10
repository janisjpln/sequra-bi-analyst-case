-- Q2.1: App engagement per platform (iOS vs Android) during H2 2024
-- Business Goal:
-- Compare user engagement between iOS and Android during the second half of 2024
-- to identify platform-specific trends and prioritize development efforts.
--
-- Logic:
-- 1. Filter sessions from July to December 2024 (H2).
-- 2. Count distinct sessions per customer to measure engagement.
-- 3. Group by platform (iOS vs Android).
-- 4. Calculate total sessions, unique users, and average sessions per user.
--
-- Assumptions:
-- - Engagement is measured as the number of app sessions.
-- - Only completed sessions (session_end is not null) are considered.
-- - app_sessions.platform contains only 'iOS' or 'Android'.

SELECT
  platform,
  COUNT(*) AS total_sessions,
  COUNT(DISTINCT customer_id) AS unique_users,
  ROUND(COUNT(*) / COUNT(DISTINCT customer_id), 2) AS avg_sessions_per_user
FROM
  `sequra-challenge-2025.sequra_challenge.app_sessions`
WHERE
  session_start >= '2024-07-01'
  AND session_start < '2025-01-01'
  AND session_end IS NOT NULL
GROUP BY
  platform
ORDER BY
  total_sessions DESC;