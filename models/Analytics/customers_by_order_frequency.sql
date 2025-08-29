WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM {{ ref('fact_orders') }}
    GROUP BY customer_id
)
SELECT
    customer_id,
    order_count,
    RANK() OVER (ORDER BY order_count DESC) AS rank
FROM customer_orders
ORDER BY rank
LIMIT 10