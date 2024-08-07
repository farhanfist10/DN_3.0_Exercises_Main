DECLARE
    CURSOR c_loans IS
        SELECT c.CustomerID, c.Name, l.LoanID
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
    FOR r_loan IN c_loans LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Customer ' || r_loan.Name || ' has a loan (ID: ' || r_loan.LoanID || ') due soon.');
    END LOOP;
END;
