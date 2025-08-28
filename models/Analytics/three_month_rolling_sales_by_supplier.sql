WITH supplier_revenue AS (
    SELECT
        li.supplier_id,  -- Use table alias to specify supplier_id clearly
        li.ship_date,
        SUM(li.extended_price * (1 - li.discount)) AS total_revenue  -- Calculate total revenue
    FROM {{ ref('fact_lineitem') }} li  -- Reference fact_lineitem table
    GROUP BY li.supplier_id, li.ship_date  -- Grouping by supplier_id and ship_date
),
rolling_revenue AS (
    SELECT
        supplier_id,
        ship_date,
        SUM(total_revenue) OVER (
            PARTITION BY supplier_id  -- Partitioning by supplier_id
            ORDER BY ship_date  -- Ordering by ship_date for rolling sum
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW  -- Defining the rolling window
        ) AS rolling_3_month_revenue  -- Aliasing the result of the rolling sum
    FROM supplier_revenue
)
SELECT * 
FROM rolling_revenue
ORDER BY rolling_3_month_revenue DESC  -- Ordering the result by rolling revenue
LIMIT 10  -- Limiting the output to the top 10