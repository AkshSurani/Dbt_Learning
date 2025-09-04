-- Identifies top 10 customers with highest and lowest account balances


WITH customer_balances AS (
    SELECT
        customer_id,
        customer_name,
        account_balance,
        nation_id
    FROM {{ ref('dim_customer') }}
),

ranked_balances AS (
    SELECT
        customer_id,
        customer_name,
        account_balance,
        nation_id,
        RANK() OVER (ORDER BY account_balance DESC) AS rank_high,
        RANK() OVER (ORDER BY account_balance ASC)  AS rank_low
    FROM customer_balances
)

SELECT
    customer_id,
    customer_name,
    account_balance,
    nation_id,
    rank_high,
    rank_low,
    
    CASE
        WHEN rank_high <= 10 THEN 'Top 10 Positive Balances'
        WHEN rank_low  <= 10 THEN 'Top 10 Negative Balances'
    END AS balance_category
FROM ranked_balances
WHERE rank_high <= 10 OR rank_low <= 10
ORDER BY balance_category, account_balance DESC