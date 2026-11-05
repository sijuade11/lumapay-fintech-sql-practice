USE lumapay_practice;

-- Count transactions in each status.
SELECT status, COUNT(*) AS number_of_transactions
FROM transactions
GROUP BY status
ORDER BY number_of_transactions DESC;

-- Show a recent sample of successful transactions.
SELECT transaction_id, account_id, amount, currency,
       transaction_type, channel, created_at
FROM transactions
WHERE status = 'successful'
ORDER BY created_at DESC
LIMIT 20;

-- Show a recent sample of transactions that are not successful.
-- This includes failed, pending, and reversed transactions.
SELECT transaction_id, account_id, amount, currency,
       transaction_type, status, channel, created_at
FROM transactions
WHERE status <> 'successful'
ORDER BY created_at DESC
LIMIT 50;

-- Show only transactions that failed.
SELECT transaction_id, account_id, amount, currency,
       transaction_type, status, channel, created_at
FROM transactions
WHERE status = 'failed'
ORDER BY created_at DESC
LIMIT 50;
