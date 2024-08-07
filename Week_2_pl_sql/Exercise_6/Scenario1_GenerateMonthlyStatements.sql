DECLARE
    CURSOR c_transactions IS
        SELECT c.CustomerID, c.Name, t.TransactionID, t.Amount, t.TransactionDate
        FROM Customers c
        JOIN Accounts a ON c.CustomerID = a.CustomerID
        JOIN Transactions t ON a.AccountID = t.AccountID
        WHERE t.TransactionDate BETWEEN TRUNC(SYSDATE, 'MM') AND LAST_DAY(SYSDATE);
BEGIN
    FOR r_transaction IN c_transactions LOOP
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || r_transaction.CustomerID || ', Name: ' || r_transaction.Name || 
                             ', Transaction ID: ' || r_transaction.TransactionID || ', Amount: ' || r_transaction.Amount ||
                             ', Date: ' || r_transaction.TransactionDate);
    END LOOP;
END;
