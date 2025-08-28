WITH order_summary AS (
    SELECT
        customer_id,
        SUM(total_price) AS total_spent,
        COUNT(order_id) AS order_count
    FROM {{ ref('fact_orders') }}
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent,
    order_count,
    total_spent / order_count AS avg_order_value
FROM order_summary
