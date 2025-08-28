WITH region AS (
    SELECT * FROM {{ ref('Stg_region') }}
)
SELECT
    region_id,
    region_name,
    REGION_COMMENT
FROM region
