WITH nation AS (
    SELECT * FROM {{ ref('Stg_nation') }}
)
SELECT
    nation_id,
    nation_name,
    region_id,
    NATION_COMMENT,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', CURRENT_TIMESTAMP()) AS row_inserted_at_ist
FROM nation
