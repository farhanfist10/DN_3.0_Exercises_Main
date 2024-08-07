CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER
) AS
BEGIN
    -- Update salary
    UPDATE Employees
    SET Salary = Salary * (1 + p_percentage / 100)
    WHERE EmployeeID = p_employee_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Employee ID does not exist.');
    END IF;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
