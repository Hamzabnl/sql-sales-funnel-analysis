-- =============================================================
-- 01. Funnel Stage Counts
-- Counts events at each stage of the funnel over the last 30 days
-- (relative to the most recent event_date in the table).
-- =============================================================

WITH funnel_stages AS (
  SELECT
    COUNT(CASE WHEN event_type = 'page_view'      THEN 1 END) AS stage1_views,
    COUNT(CASE WHEN event_type = 'add_to_cart'     THEN 1 END) AS stage2_cart,
    COUNT(CASE WHEN event_type = 'checkout_start'  THEN 1 END) AS stage3_checkout,
    COUNT(CASE WHEN event_type = 'payment_info'    THEN 1 END) AS stage4_payment,
    COUNT(CASE WHEN event_type = 'purchase'        THEN 1 END) AS stage5_purchase
  FROM `data-analysis-project-507915.sql_practice.data`
  WHERE event_date >= TIMESTAMP_SUB(
    (SELECT MAX(event_date) FROM `data-analysis-project-507915.sql_practice.data`),
    INTERVAL 30 DAY
  )
)
SELECT * FROM funnel_stages;
