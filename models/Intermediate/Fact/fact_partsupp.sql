WITH partsupp AS (
    SELECT * FROM {{ ref('Stg_partsupp') }}
)
SELECT
    part_id,
    supplier_id,
    available_qty,
    supply_cost,
    PARTSUPP_COMMENT
FROM partsupp

{# with partsupp as (
  select * from {{ ref('stg_partsupp') }}
)

select
  cast(part_id as varchar) || '-' || cast(supplier_id as varchar) as partsupp_id,
  part_id,
  supplier_id,
  available_qty,
  supply_cost,
  partsupp_comment
from partsupp #}
