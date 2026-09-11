-- =============================================================
-- 05. Revenue Funnel Analysis
-- Ties the funnel to revenue: conversion rate, average order
-- value, average value per buyer and per visitor, last 30 days.
-- =============================================================

WITH funnel_revenue AS (
  SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitors,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase'  THEN user_id END) AS total_buyers,
    ROUND(SUM(CASE WHEN event_type = 'purchase' THEN amount END), 2)    AS total_revenue,
    COUNT(CASE WHEN event_type = 'purchase' THEN 1 END)                 AS total_orders
  FROM `data-analysis-project-507915.sql_practice.data`
  WHERE event_date >= TIMESTAMP_SUB(
    (SELECT MAX(event_date) FROM `data-analysis-project-507915.sql_practice.data`),
    INTERVAL 30 DAY
  )
)
SELECT
  total_visitors,
  total_buyers,
  ROUND(SAFE_DIVIDE(total_buyers, total_visitors) * 100, 2) AS conversion_rate_pct,
  total_orders,
  total_revenue,
  ROUND(SAFE_DIVIDE(total_revenue, total_orders), 2)    AS avg_order_value,
  ROUND(SAFE_DIVIDE(total_revenue, total_buyers), 2)    AS avg_revenue_per_buyer,
  ROUND(SAFE_DIVIDE(total_revenue, total_visitors), 2)  AS avg_revenue_per_visitor
FROM funnel_revenue;
