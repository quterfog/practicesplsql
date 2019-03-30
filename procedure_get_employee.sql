CREATE OR REPLACE PROCEDURE get_employee
            (p_empid employees.employee_id%TYPE,
            p_sal OUT employees.salary%TYPE,
            p_jobid OUT employees.job_id%TYPE)
    AS
BEGIN
    SELECT salary, job_id 
    INTO p_sal, p_jobid
    FROM employees
    WHERE employee_id = p_empid;
END get_employee;
/

VARIABLE v_salary NUMBER
VARIABLE v_job VARCHAR2

EXEC get_employee(300,:v_salary,:v_job);
/
PRINT v_salary
PRINT v_job
