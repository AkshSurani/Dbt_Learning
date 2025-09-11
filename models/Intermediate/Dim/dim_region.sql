WITH stg_region AS (
    SELECT * FROM {{ ref('Stg_region') }}
)

SELECT
    region_id,
    region_name,
    region_comment,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', CURRENT_TIMESTAMP()) AS row_inserted_at_ist
FROM stg_region
