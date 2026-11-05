USE lumapay_practice;

-- Compare transaction outcomes by channel.
SELECT channel, status, COUNT(*) AS number_of_transactions
FROM transactions
GROUP BY channel, status
ORDER BY channel, status;

-- Find high-value transactions. Review status and alert details before deciding
-- whether a result is a defect.
SELECT transactions.transaction_id,
       accounts.account_id,
       customers.full_name,
       transactions.amount,
       transactions.status,
       transactions.created_at
FROM transactions
JOIN accounts
    ON accounts.account_id = transactions.account_id
JOIN customers
    ON customers.customer_id = accounts.customer_id
WHERE transactions.amount > 100000
ORDER BY transactions.amount DESC
LIMIT 50;

-- Check for duplicate transaction IDs. The primary key should prevent them;
-- this query should return no rows.
SELECT transaction_id, COUNT(*) AS number_of_matching_rows
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- Count open fraud alerts.
SELECT COUNT(*) AS number_of_open_alerts
FROM fraud_alerts
WHERE status = 'open';
