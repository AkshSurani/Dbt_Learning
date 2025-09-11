WITH part AS (
    SELECT * FROM {{ ref('Stg_parts') }}
)
SELECT
    part_id,
    part_name,
    manufacturer,
    brand,
    part_type,
    part_size,
    container,
    retail_price,
    PART_COMMENT,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', CURRENT_TIMESTAMP()) AS row_inserted_at_ist
FROM part

