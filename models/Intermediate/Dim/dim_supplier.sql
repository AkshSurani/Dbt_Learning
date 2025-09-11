WITH partsupp AS 
( SELECT * FROM {{ ref('Stg_supplier') }} ) 
SELECT    
    supplier_id, 
    SUPPLIER_NAME,
    nation_id,
    SUPPLIER_PHONE, 
    ACCOUNT_BALANCE,
    SUPPLIER_COMMENT,
    CONVERT_TIMEZONE('UTC', 'Asia/Kolkata', CURRENT_TIMESTAMP()) AS row_inserted_at_ist
FROM partsupp
