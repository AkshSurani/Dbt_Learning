WITH region AS (
    SELECT * FROM {{ ref('region') }}  
)

SELECT
    TRY_CAST(R_REGIONKEY AS INT) AS region_id,
    LEFT(TRIM(R_NAME), 25) AS region_name,
    LEFT(TRIM(R_COMMENT), 152) AS region_comment
FROM region