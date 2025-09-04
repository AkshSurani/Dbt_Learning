-- Counts the number of suppliers per nation to identify top countries by supplier presence


WITH supplier_count AS (
    SELECT
        n.NATION_NAME,
        COUNT(s.SUPPLIER_ID) AS supplier_count
    FROM {{ ref('dim_supplier') }} s
    JOIN {{ ref('dim_nation') }} n
        ON s.NATION_ID = n.NATION_ID
    GROUP BY n.NATION_NAME
    
)
 SELECT 
     NATION_NAME,
     supplier_count
 FROM supplier_count
 ORDER BY supplier_count DESC
