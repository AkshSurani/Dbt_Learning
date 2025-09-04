-- Calculates total revenue per supplier, including discounted sales, for performance analysis

WITH revenue_per_supplier AS (
    SELECT
        supplier_id,
        SUM(extended_price * (1 - discount)) AS total_revenue
    FROM {{ ref('fact_lineitem') }}
    GROUP BY supplier_id
)

SELECT
    supplier_id,
    total_revenue,
    ROUND(total_revenue / 100000, 2) AS total_revenue_in_million_$
FROM revenue_per_supplier
