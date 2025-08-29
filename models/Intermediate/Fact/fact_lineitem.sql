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
    LINE_COMMENT
FROM lineitem

{% if is_incremental() %}
  -- only insert new or updated rows
  WHERE (order_id, line_number, part_id, supplier_id) 
        NOT IN (SELECT order_id, line_number, part_id, supplier_id FROM {{ this }})
{% endif %}

{# with lineitem as (
  select * from {{ ref('Stg_lineitem') }}
)

select
  -- stable textual surrogate key: "orderid-linenumber-partid-suppid"
  cast(order_id as varchar) || '-' || cast(line_number as varchar) || '-' || cast(part_id as varchar) || '-' || cast(supplier_id as varchar) as lineitem_id,
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
  line_comment
from lineitem #}
