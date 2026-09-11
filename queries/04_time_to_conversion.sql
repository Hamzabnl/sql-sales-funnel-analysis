-- =============================================================
-- 04. Time-to-Conversion Analysis
-- For users who purchased in the last 30 days, measures average
-- minutes spent moving between funnel stages.
-- =============================================================

WITH user_journey AS (
  SELECT
    user_id,
    MIN(CASE WHEN event_type = 'page_view'   THEN event_date END) AS view_time,
    MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
    MIN(CASE WHEN event_type = 'purchase'    THEN event_date END) AS purchase_time
  FROM `data-analysis-project-507915.sql_practice.data`
  WHERE event_date >= TIMESTAMP_SUB(
    (SELECT MAX(event_date) FROM `data-analysis-project-507915.sql_practice.data`),
    INTERVAL 30 DAY
  )
  GROUP BY user_id
  HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL
)
SELECT
  COUNT(DISTINCT user_id) AS converted_users,
  ROUND(AVG(TIMESTAMP_DIFF(cart_time, view_time, MINUTE)), 2)     AS avg_view_to_cart_minutes,
  ROUND(AVG(TIMESTAMP_DIFF(purchase_time, cart_time, MINUTE)), 2) AS avg_cart_to_purchase_minutes,
  ROUND(AVG(TIMESTAMP_DIFF(purchase_time, view_time, MINUTE)), 2) AS avg_view_to_purchase_minutes
FROM user_journey;
