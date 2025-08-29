WITH yearly_revenue AS (
    SELECT
        YEAR(ship_date) AS year,
        SUM(extended_price * (1 - discount)) AS total_revenue
    FROM {{ ref('fact_lineitem') }}
    GROUP BY YEAR(ship_date)
),
revenue_growth AS (
    SELECT
        year,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY year) AS prev_year_revenue,
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year)) / LAG(total_revenue) OVER (ORDER BY year) AS yoy_growth
    FROM yearly_revenue
)
SELECT
    year,
    total_revenue,
    yoy_growth
FROM revenue_growth
ORDER BY year