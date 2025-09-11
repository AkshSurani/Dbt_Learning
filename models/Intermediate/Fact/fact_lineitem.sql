{{ config(
    materialized='incremental',
    unique_key=['order_id', 'line_number', 'part_id', 'supplier_id']
) }}

WITH lineitem AS (
    SELECT * FROM {{ ref('Stg_lineitem') }}
)
SELECT
    order_id,
    part_id,
    supplier_id,
    line_number,
    quantity,
    extended_price,
    discount,
    tax,
    return_flag,
    line_status,
    ship_date,
    commit_date,
    receipt_date,
    ship_instruct,
    ship_mode,
    LINE_COMMENT,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', CURRENT_TIMESTAMP()) AS row_inserted_at_ist
FROM lineitem

{% if is_incremental() %}
  -- only insert new or updated rows
  WHERE (order_id, line_number, part_id, supplier_id) 
        NOT IN (SELECT order_id, line_number, part_id, supplier_id FROM {{ this }})
{% endif %}
