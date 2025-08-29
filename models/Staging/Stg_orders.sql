WITH orders AS (
    SELECT * FROM {{ source('SF1_RAW', 'orders') }}
)

SELECT
    TRY_CAST(O_ORDERKEY AS INT  ) AS order_id,
    TRY_CAST(O_CUSTKEY AS INT  ) AS customer_id,
    LEFT(TRIM(O_ORDERSTATUS), 1) AS order_status,
    TRY_CAST(O_TOTALPRICE AS DECIMAL(12,2)) AS total_price,
    TRY_CAST(O_ORDERDATE AS DATE) AS order_date,
    LEFT(TRIM(O_ORDERPRIORITY), 15) AS order_priority,
    LEFT(TRIM(O_CLERK), 15) AS clerk,
    TRY_CAST(O_SHIPPRIORITY AS INT   ) AS ship_priority,
    LEFT(TRIM(O_COMMENT), 79) AS order_comment
FROM orders
