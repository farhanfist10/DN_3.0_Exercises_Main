CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF :NEW.TransactionType = 'Withdrawal' THEN
        DECLARE
            v_balance NUMBER;
        BEGIN
            SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = :NEW.AccountID;
            IF v_balance < :NEW.Amount THEN
                RAISE_APPLICATION_ERROR(-20006, 'Insufficient balance for withdrawal.');
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20007, 'Account does not exist.');
        END;
    ELSIF :NEW.TransactionType = 'Deposit' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20008, 'Deposit amount must be positive.');
        END IF;
    END IF;
END;
