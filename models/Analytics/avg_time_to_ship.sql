WITH shipping_times AS (
    SELECT
        order_id,
        ship_date,
        LEAD(ship_date) OVER (PARTITION BY order_id ORDER BY ship_date) AS next_ship_date
    FROM {{ ref('fact_lineitem') }}
),
shipping_diff AS (
    SELECT
        order_id,
        ship_date,
        next_ship_date,
        DATEDIFF('day', ship_date, next_ship_date) AS days_to_ship
    FROM shipping_times
    WHERE next_ship_date IS NOT NULL
)
SELECT
    AVG(days_to_ship) AS avg_time_to_ship
FROM shipping_diff