WITH part AS (
    SELECT * FROM {{ source('SF1_RAW', 'part') }}
)

SELECT
    TRY_CAST(P_PARTKEY AS INT  ) AS part_id,
    LEFT(TRIM(P_NAME), 55) AS part_name,
    LEFT(TRIM(P_MFGR), 25) AS manufacturer,
    LEFT(TRIM(P_BRAND), 10) AS brand,
    LEFT(TRIM(P_TYPE), 25) AS part_type,
    TRY_CAST(P_SIZE AS INT  ) AS part_size,
    LEFT(TRIM(P_CONTAINER), 10) AS container,
    TRY_CAST(P_RETAILPRICE AS DECIMAL(12,2)) AS retail_price,
    LEFT(TRIM(P_COMMENT), 23) AS part_comment
FROM part
