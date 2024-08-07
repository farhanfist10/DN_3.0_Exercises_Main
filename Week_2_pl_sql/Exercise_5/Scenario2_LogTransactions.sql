CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (LogID, TransactionID, ActionDate, ActionType)
    VALUES (AuditLog_seq.NEXTVAL, :NEW.TransactionID, SYSDATE, 'INSERT');
END;
