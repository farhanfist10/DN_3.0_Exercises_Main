DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Balance
        FROM Customers;
BEGIN
    FOR r_customer IN c_customers LOOP
        IF r_customer.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = TRUE
            WHERE CustomerID = r_customer.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
END;
