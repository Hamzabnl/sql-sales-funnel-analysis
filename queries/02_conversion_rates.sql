-- =============================================================
-- 02. Conversion Rates Between Funnel Stages
-- Step-by-step and overall conversion rate (%), last 30 days.
-- Uses SAFE_DIVIDE so a stage with 0 events never errors out.
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
SELECT
  ROUND(SAFE_DIVIDE(stage2_cart, stage1_views)     * 100, 2) AS view_to_cart_rate,
  ROUND(SAFE_DIVIDE(stage3_checkout, stage2_cart)  * 100, 2) AS cart_to_checkout_rate,
  ROUND(SAFE_DIVIDE(stage4_payment, stage3_checkout) * 100, 2) AS checkout_to_payment_rate,
  ROUND(SAFE_DIVIDE(stage5_purchase, stage4_payment) * 100, 2) AS payment_to_purchase_rate,
  ROUND(SAFE_DIVIDE(stage5_purchase, stage1_views) * 100, 2) AS overall_conversion_rate
FROM funnel_stages;
