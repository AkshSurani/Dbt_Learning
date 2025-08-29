WITH partsupp AS 
( SELECT * FROM {{ ref('Stg_supplier') }} ) 
SELECT    
    supplier_id, 
    SUPPLIER_NAME,
    nation_id,
    SUPPLIER_PHONE, 
    ACCOUNT_BALANCE,
    SUPPLIER_COMMENT 
FROM partsupp
