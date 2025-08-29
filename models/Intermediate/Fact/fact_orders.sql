{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

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

{% if is_incremental() %}
  WHERE order_id NOT IN (SELECT order_id FROM {{ this }})
{% endif %}