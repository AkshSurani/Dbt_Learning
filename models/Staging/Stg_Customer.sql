WITH customer AS (
    SELECT * FROM {{ source('SF1_RAW', 'customer') }}
)
SELECT
    TRY_CAST(C_CUSTKEY AS INT ) AS customer_id,
    LEFT(TRIM(C_NAME), 25) AS customer_name,
    LEFT(TRIM(C_ADDRESS), 40) AS customer_address,
    TRY_CAST(C_NATIONKEY AS INT ) AS nation_id,
    LEFT(TRIM(C_PHONE), 15) AS customer_phone,
    TRY_CAST(C_ACCTBAL AS DECIMAL(12,2)) AS account_balance,
    LEFT(TRIM(C_MKTSEGMENT), 10) AS market_segment,
    LEFT(TRIM(C_COMMENT), 117) AS customer_comment

FROM customer