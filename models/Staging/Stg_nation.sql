WITH nation AS (
    SELECT * FROM {{ source('SF1_RAW', 'nation') }}
)

SELECT
    TRY_CAST(N_NATIONKEY AS INT  ) AS nation_id,
    LEFT(TRIM(N_NAME), 25) AS nation_name,
    TRY_CAST(N_REGIONKEY AS INT  ) AS region_id,
    LEFT(TRIM(N_COMMENT), 152) AS nation_comment
FROM nation
