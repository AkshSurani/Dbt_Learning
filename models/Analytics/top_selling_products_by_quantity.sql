WITH product_sales AS (
    SELECT
        part_id,
        SUM(quantity) AS total_quantity
    FROM {{ ref('fact_lineitem') }}
    GROUP BY part_id
)
SELECT
    part_id,
    total_quantity,
    RANK() OVER (ORDER BY total_quantity DESC) AS rank
FROM product_sales
ORDER BY rank
LIMIT 10