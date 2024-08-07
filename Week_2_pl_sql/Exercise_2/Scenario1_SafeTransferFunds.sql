CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) AS
BEGIN
    -- Start transaction
    BEGIN
        -- Check balance
        DECLARE
            v_balance NUMBER;
        BEGIN
            SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_from_account FOR UPDATE;
            IF v_balance < p_amount THEN
                RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds.');
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20002, 'Source account does not exist.');
        END;

        -- Perform transfer
        UPDATE Accounts SET Balance = Balance - p_amount WHERE AccountID = p_from_account;
        UPDATE Accounts SET Balance = Balance + p_amount WHERE AccountID = p_to_account;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- Log the error and rollback
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
