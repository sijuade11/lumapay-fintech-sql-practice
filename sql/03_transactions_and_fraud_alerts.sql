USE lumapay_practice;

-- Show the customer, account, transaction, and alert details for transactions
-- that have a fraud alert. One result row is returned per matching alert.
SELECT customers.customer_id,
       customers.full_name,
       accounts.account_id,
       transactions.transaction_id,
       transactions.amount,
       transactions.status AS transaction_status,
       fraud_alerts.alert_id,
       fraud_alerts.reason,
       fraud_alerts.severity,
       fraud_alerts.status AS alert_status,
       fraud_alerts.created_at AS alert_created_at
FROM customers
JOIN accounts
    ON accounts.customer_id = customers.customer_id
JOIN transactions
    ON transactions.account_id = accounts.account_id
JOIN fraud_alerts
    ON fraud_alerts.transaction_id = transactions.transaction_id
ORDER BY fraud_alerts.created_at DESC
LIMIT 50;

-- Show transactions that do not have a fraud alert.
-- LEFT JOIN keeps all transactions; NULL means there was no matching alert.
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
LEFT JOIN fraud_alerts
    ON fraud_alerts.transaction_id = transactions.transaction_id
WHERE fraud_alerts.alert_id IS NULL
ORDER BY transactions.created_at DESC
LIMIT 50;

-- Show open or investigating alerts first, with their customer and transaction.
SELECT customers.full_name,
       accounts.account_id,
       transactions.transaction_id,
       transactions.amount,
       transactions.risk_score,
       transactions.status AS transaction_status,
       fraud_alerts.reason,
       fraud_alerts.severity,
       fraud_alerts.status AS alert_status
FROM fraud_alerts
JOIN transactions
    ON transactions.transaction_id = fraud_alerts.transaction_id
JOIN accounts
    ON accounts.account_id = transactions.account_id
JOIN customers
    ON customers.customer_id = accounts.customer_id
WHERE fraud_alerts.status IN ('open', 'investigating')
ORDER BY transactions.risk_score DESC
LIMIT 50;
