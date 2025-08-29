WITH nation AS (
    SELECT * FROM {{ ref('Stg_nation') }}
)
SELECT
    nation_id,
    nation_name,
    region_id,
    NATION_COMMENT
FROM nation
