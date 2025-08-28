WITH supplier_profit AS (
    SELECT
        li.supplier_id,  -- Specify the alias to remove ambiguity
        SUM((li.extended_price - ps.supply_cost) * (1 - li.discount)) AS total_profit  -- Specify table aliases
    FROM {{ ref('fact_lineitem') }} li
    JOIN {{ ref('fact_partsupp') }} ps ON li.part_id = ps.part_id AND li.supplier_id = ps.supplier_id
    GROUP BY li.supplier_id  -- Specify the alias to remove ambiguity
)
SELECT
    supplier_id,
    total_profit,
    RANK() OVER (ORDER BY total_profit DESC) AS rank
FROM supplier_profit
ORDER BY rank
LIMIT 10