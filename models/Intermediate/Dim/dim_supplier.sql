WITH partsupp AS 
( SELECT * FROM {{ ref('Stg_partsupp') }} ) 
SELECT    
    part_id, 
    supplier_id, 
    available_qty, 
    supply_cost,
    PARTSUPP_COMMENT 
FROM partsupp
