USE lumapay_practice;

-- Each result row is one transaction that is failed, pending, or reversed.
-- A customer can appear more than once if they have multiple such transactions.
SELECT customers.customer_id,
       customers.full_name,
       customers.email,
       accounts.account_id,
       transactions.transaction_id,
       transactions.amount,
       transactions.currency,
       transactions.status,
       transactions.created_at
FROM customers
JOIN accounts
    ON accounts.customer_id = customers.customer_id
JOIN transactions
    ON transactions.account_id = accounts.account_id
WHERE transactions.status <> 'successful'
ORDER BY transactions.created_at DESC
LIMIT 50;

-- Change the WHERE line to this if you only want failed transactions:
-- WHERE transactions.status = 'failed'
