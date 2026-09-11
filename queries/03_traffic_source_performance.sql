-- =============================================================
-- 03. Funnel Performance by Traffic Source
-- Compares view→cart→purchase conversion across acquisition
-- channels, last 30 days.
-- =============================================================

WITH funnel_by_source AS (
  SELECT
    traffic_source,
    COUNT(CASE WHEN event_type = 'page_view'   THEN 1 END) AS views,
    COUNT(CASE WHEN event_type = 'add_to_cart' THEN 1 END) AS cart,
    COUNT(CASE WHEN event_type = 'purchase'    THEN 1 END) AS purchase
  FROM `data-analysis-project-507915.sql_practice.data`
  WHERE event_date >= TIMESTAMP_SUB(
    (SELECT MAX(event_date) FROM `data-analysis-project-507915.sql_practice.data`),
    INTERVAL 30 DAY
  )
  GROUP BY traffic_source
)
SELECT
  traffic_source,
  views,
  cart,
  purchase,
  ROUND(SAFE_DIVIDE(cart, views)    * 100, 2) AS cart_rate,
  ROUND(SAFE_DIVIDE(purchase, cart) * 100, 2) AS cart_to_purchase_rate,
  ROUND(SAFE_DIVIDE(purchase, views) * 100, 2) AS purchase_rate
FROM funnel_by_source
ORDER BY purchase_rate DESC;
