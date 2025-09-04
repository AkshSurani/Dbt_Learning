-- Lists parts with low stock (≤10 units) along with supplier info for restocking priority

WITH low_stock AS (
    SELECT
        ps.PART_ID,
        p.PART_NAME,
        ps.SUPPLIER_ID,
        s.SUPPLIER_NAME,
        ps.AVAILABLE_QTY
    FROM {{ ref('fact_partsupp') }} ps
    JOIN {{ ref('dim_part') }} p
        ON ps.PART_ID = p.PART_ID
    JOIN {{ ref('dim_supplier') }} s
        ON ps.SUPPLIER_ID = s.SUPPLIER_ID
    WHERE ps.AVAILABLE_QTY <= 10
)
SELECT *
FROM low_stock
ORDER BY available_qty ASC