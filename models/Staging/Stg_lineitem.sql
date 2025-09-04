WITH lineitem AS (
    SELECT * FROM {{ source('SF1_RAW', 'lineitem') }}
)

SELECT
    TRY_CAST(L_ORDERKEY AS INT) AS order_id,
    TRY_CAST(L_PARTKEY AS INT ) AS part_id,
    TRY_CAST(L_SUPPKEY AS INT) AS supplier_id,
    TRY_CAST(L_LINENUMBER AS INT) AS line_number,
    TRY_CAST(L_QUANTITY AS DECIMAL(12,2)) AS quantity,
    TRY_CAST(L_EXTENDEDPRICE AS DECIMAL(12,2)) AS extended_price,
    TRY_CAST(L_DISCOUNT AS DECIMAL(12,2)) AS discount,
    TRY_CAST(L_TAX AS DECIMAL(12,2)) AS tax,
    LEFT(TRIM(L_RETURNFLAG), 1) AS return_flag,
    LEFT(TRIM(L_LINESTATUS), 1) AS line_status,
    TRY_CAST(L_SHIPDATE AS DATE) AS ship_date,
    TRY_CAST(L_COMMITDATE AS DATE) AS commit_date,
    TRY_CAST(L_RECEIPTDATE AS DATE) AS receipt_date,
    LEFT(TRIM(L_SHIPINSTRUCT), 25) AS ship_instruct,
    LEFT(TRIM(L_SHIPMODE), 10) AS ship_mode,
    LEFT(TRIM(L_COMMENT), 44) AS line_comment
FROM lineitem
