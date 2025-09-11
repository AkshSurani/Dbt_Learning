WITH partsupp AS (
    SELECT * FROM {{ ref('Stg_partsupp') }}
)
SELECT
    part_id,
    supplier_id,
    available_qty,
    supply_cost,
    PARTSUPP_COMMENT,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', CURRENT_TIMESTAMP()) AS row_inserted_at_ist
FROM partsupp
