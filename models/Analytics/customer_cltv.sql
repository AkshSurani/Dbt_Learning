-- Calculates Customer Lifetime Value (CLV) and average order value per customer--

WITH customer_orders AS (
    SELECT
        customer_id,
        SUM({{ net_revenue('total_price', '0') }}) AS total_spent,
        COUNT(order_id) AS order_count
    FROM {{ ref('fact_orders') }}
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent,
    order_count,
    total_spent / NULLIF(order_count, 0) AS avg_order_value,
    total_spent AS lifetime_value  -- Simplified CLV
FROM customer_orders
ORDER BY lifetime_value DESC
