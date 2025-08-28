WITH customer AS (
    SELECT * FROM {{ ref('Stg_Customer') }}
)
SELECT
    customer_id,
    customer_name,
    customer_address,
    nation_id,
    customer_phone,
    account_balance,
    market_segment,
    customer_comment 
FROM customer 

