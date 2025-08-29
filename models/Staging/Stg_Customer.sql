{# select * from 
{{source('SF1_RAW','customer')}}

 #}

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

{# 

WITH customer AS (

    SELECT
        TRY_CAST(C_CUSTKEY AS INT)              AS customer_id,
        LEFT(TRIM(C_NAME), 25)                  AS customer_name,
        LEFT(TRIM(C_ADDRESS), 40)               AS customer_address,
        TRY_CAST(C_NATIONKEY AS INT)            AS nation_id,
        LEFT(TRIM(C_PHONE), 15)                 AS customer_phone,
        TRY_CAST(C_ACCTBAL AS DECIMAL(12,2))    AS account_balance,
        LEFT(TRIM(C_MKTSEGMENT), 10)            AS market_segment,
        LEFT(TRIM(C_COMMENT), 117)              AS customer_comment
    FROM {{ source('SF1_RAW', 'customer') }}

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
FROM customer #}


{# 
{{ config(materialized='view') }}

WITH customer AS (
    SELECT 
        DISTINCT   -- remove duplicates
        TRY_CAST(C_CUSTKEY AS INT) AS customer_id,
        TRIM(C_NAME) AS customer_name,
        TRIM(C_ADDRESS) AS customer_address,
        TRY_CAST(C_NATIONKEY AS INT) AS nation_id,
        TRY_CAST(C_ACCTBAL AS DECIMAL(12,2)) AS account_balance,
        TRIM(C_MKTSEGMENT) AS market_segment,
        TRIM(C_COMMENT) AS customer_comment
    FROM {{ source('SF1_RAW', 'customer') }}
    WHERE C_CUSTKEY IS NOT NULL  -- remove invalid rows
)

SELECT * FROM customer #}