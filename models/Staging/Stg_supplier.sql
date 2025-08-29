WITH supplier AS (
    SELECT * FROM {{ source('SF1_RAW', 'supplier') }}
)

SELECT
    TRY_CAST(S_SUPPKEY AS INT  ) AS supplier_id,
    LEFT(TRIM(S_NAME), 25) AS supplier_name,
    LEFT(TRIM(S_ADDRESS), 40) AS supplier_address,
    TRY_CAST(S_NATIONKEY AS INT  ) AS nation_id,
    LEFT(TRIM(S_PHONE), 15) AS supplier_phone,
    TRY_CAST(S_ACCTBAL AS DECIMAL(12,2)) AS account_balance,
    LEFT(TRIM(S_COMMENT), 101) AS supplier_comment
FROM supplier
