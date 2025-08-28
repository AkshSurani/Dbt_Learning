WITH part_sales AS (
    SELECT
        part_id,
        SUM(quantity * extended_price) AS total_sales
    FROM {{ ref('fact_lineitem') }}
    GROUP BY part_id
)
SELECT
    part_id,
    total_sales
FROM part_sales
