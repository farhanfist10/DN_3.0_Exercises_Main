DECLARE
    CURSOR c_accounts IS
        SELECT AccountID, Balance
        FROM Accounts;
BEGIN
    FOR r_account IN c_accounts LOOP
        UPDATE Accounts
        SET Balance = Balance - 50
        WHERE AccountID = r_account.AccountID;
    END LOOP;
    COMMIT;
END;
