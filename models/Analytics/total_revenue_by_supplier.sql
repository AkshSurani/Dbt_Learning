WITH revenue_summary AS (
    SELECT
        supplier_id,
        SUM(extended_price * (1 - discount)) AS total_revenue
    FROM {{ ref('fact_lineitem') }}
    GROUP BY supplier_id
)
SELECT
    supplier_id,
    total_revenue
FROM revenue_summary
