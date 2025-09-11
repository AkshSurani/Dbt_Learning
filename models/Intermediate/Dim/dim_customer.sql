-- WITH customer AS (
--     SELECT * FROM {{ ref('Stg_Customer') }}
-- )
-- SELECT
--     customer_id,
--     customer_name,
--     customer_address,
--     nation_id,
--     customer_phone,
--     account_balance,
--     market_segment,
--     customer_comment 
-- FROM customer 

WITH customer AS (
    SELECT * FROM {{ ref('customer_snapshot') }}
)
SELECT
    customer_id,
    customer_name,
    customer_address,
    nation_id,
    customer_phone,
    account_balance,
    market_segment,
    customer_comment,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', CURRENT_TIMESTAMP()) AS row_inserted_at_ist,
    dbt_valid_from,
    dbt_valid_to
FROM customer
