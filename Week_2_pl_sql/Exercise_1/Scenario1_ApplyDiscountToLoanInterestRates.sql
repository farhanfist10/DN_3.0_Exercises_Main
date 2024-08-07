DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, DOB, InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID;
    v_age NUMBER;
BEGIN
    FOR r_customer IN c_customers LOOP
        -- Calculate age
        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, r_customer.DOB) / 12);

        -- Apply discount if age > 60
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = r_customer.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
END;
