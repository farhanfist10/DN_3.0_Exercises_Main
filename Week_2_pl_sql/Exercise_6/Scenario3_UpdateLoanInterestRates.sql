DECLARE
    CURSOR c_loans IS
        SELECT LoanID, InterestRate
        FROM Loans;
BEGIN
    FOR r_loan IN c_loans LOOP
        -- Assuming new policy reduces interest rate by 0.5%
        UPDATE Loans
        SET InterestRate = InterestRate - 0.5
        WHERE LoanID = r_loan.LoanID;
    END LOOP;
    COMMIT;
END;