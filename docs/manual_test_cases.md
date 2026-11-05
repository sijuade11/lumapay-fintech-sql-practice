# Manual testing checks

Use these checks with the SQL files. The dataset is simulated, so the results are practice evidence rather than real company findings.

| Check | Steps | Expected result |
| --- | --- | --- |
| Transaction status totals | Run the first query in `01_transaction_outcomes.sql`. | The counts are successful 6,880; failed 1,678; pending 1,743; reversed 1,699. They add up to 12,000. |
| Customer and account connection | Run `02_customers_with_unsuccessful_transactions.sql`. | Every listed transaction connects through its account to a customer. Status is failed, pending, or reversed. |
| Failed-only filter | Change the query filter to `transactions.status = 'failed'`. | Only failed transactions appear. Successful, pending, and reversed records do not appear. |
| Fraud alert connection | Run the first query in `03_transactions_and_fraud_alerts.sql`. | Each alert is shown with the transaction it references and the customer who owns the account. |
| Transactions without an alert | Run the second query in `03_transactions_and_fraud_alerts.sql`. | Rows show transactions for which no matching fraud alert exists. |
| Open alert review | Run the last query in `03_transactions_and_fraud_alerts.sql`. | Only open or investigating alerts appear; the highest risk scores are listed first. |
| Duplicate transaction identifier | Run the duplicate check in `04_more_qa_checks.sql`. | No rows should be returned because `transaction_id` is a primary key. |

## Example bug report template

If an observed result breaks an expected rule, capture:

- **Title:** short description of the issue
- **Environment:** MySQL Workbench and MySQL Server versions
- **Steps to reproduce:** exact query or actions
- **Expected result:** what should happen
- **Actual result:** what happened instead
- **Evidence:** screenshot or result rows
- **Impact:** why a customer, account, payment, or reviewer is affected

Do not call an unusual result a bug until the requirement says what the correct behavior should be.
