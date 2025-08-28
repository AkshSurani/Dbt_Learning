WITH customer_revenue AS (
    SELECT
        customer_id,
        order_date,
        SUM(total_price) AS order_revenue
    FROM {{ ref('fact_orders') }}
    GROUP BY customer_id, order_date
),
cumulative_revenue AS (
    SELECT
        customer_id,
        order_date,
        SUM(order_revenue) OVER (PARTITION BY customer_id ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
    FROM customer_revenue
)
SELECT
    customer_id,
    order_date,
    cumulative_revenue
FROM cumulative_revenue
ORDER BY customer_id, order_date