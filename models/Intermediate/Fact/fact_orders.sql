WITH orders AS (
    SELECT * FROM {{ ref('Stg_orders') }}
)
SELECT
    order_id,
    customer_id,
    order_status,
    total_price,
    order_date,
    order_priority,
    clerk,
    ship_priority,
    ORDER_COMMENT
    
FROM orders
