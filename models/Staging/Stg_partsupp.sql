WITH partsupp AS (
    SELECT * FROM {{ source('SF1_RAW', 'partsupp') }}
)

SELECT
    TRY_CAST(PS_PARTKEY AS INT  ) AS part_id,
    TRY_CAST(PS_SUPPKEY AS INT  ) AS supplier_id,
    TRY_CAST(PS_AVAILQTY AS INT   ) AS available_qty,
    TRY_CAST(PS_SUPPLYCOST AS DECIMAL(12,2)) AS supply_cost,
    LEFT(TRIM(PS_COMMENT), 199) AS partsupp_comment
FROM partsupp
