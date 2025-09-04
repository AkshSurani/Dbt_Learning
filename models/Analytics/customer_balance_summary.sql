-- This KPI summarizes customer account balances into Positive, Negative, and Zero categories.
-- Positive balances indicate customers with available credit who can make new purchases.
-- Negative balances indicate customers who owe money and may require follow-up for payment collection.

WITH customer_balance AS (
    SELECT
        CASE 
            WHEN ACCOUNT_BALANCE > 0 THEN 'Positive'
            WHEN ACCOUNT_BALANCE < 0 THEN 'Negative'
            ELSE 'Zero'
        END AS balance_type,
        ACCOUNT_BALANCE
    FROM {{ ref('dim_customer') }}
),
summary AS (
    SELECT
        balance_type,
        COUNT(*) AS customer_count,
        SUM(ACCOUNT_BALANCE) AS total_balance
    FROM customer_balance
    GROUP BY balance_type
),
with_total AS (
    SELECT * FROM summary
    UNION ALL
    SELECT 
        'Total' AS balance_type,
        SUM(customer_count),
        SUM(total_balance)
    FROM summary
)

SELECT *
FROM with_total
ORDER BY 
    CASE balance_type
        WHEN 'Positive' THEN 1
        WHEN 'Negative' THEN 2
        WHEN 'Zero' THEN 3
        WHEN 'Total' THEN 4
    END