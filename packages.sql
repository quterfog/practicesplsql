CREATE OR REPLACE PACKAGE emp_pkg AS
  PROCEDURE add_employee
      (p_fname IN employees.first_name%TYPE,
       p_lname IN employees.last_name%TYPE,
       p_email IN employees.email%TYPE,
       p_jobid IN employees.job_id%TYPE := 'SA_REP',
       p_mgr   IN employees.manager_id%TYPE := 145,
       p_sal   IN employees.salary%TYPE := 1000,
       p_comm  IN employees.commission_pct%TYPE := 0,
       p_dpid  IN employees.department_id%TYPE := 30);
  PROCEDURE get_employee
            (p_empid employees.employee_id%TYPE,
            p_sal OUT employees.salary%TYPE,
            p_jobid OUT employees.job_id%TYPE);
END emp_pkg;
/
CREATE OR REPLACE PACKAGE BODY emp_pkg AS
  PROCEDURE get_employee
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

PROCEDURE add_employee
      (p_fname IN employees.first_name%TYPE,
       p_lname IN employees.last_name%TYPE,
       p_email IN employees.email%TYPE,
       p_jobid IN employees.job_id%TYPE := 'SA_REP',
       p_mgr   IN employees.manager_id%TYPE := 145,
       p_sal   IN employees.salary%TYPE := 1000,
       p_comm  IN employees.commission_pct%TYPE := 0,
       p_dpid  IN employees.department_id%TYPE := 30)
       AS
BEGIN
    IF valid_deptid(p_dpid) THEN
    INSERT INTO employees 
    (employee_id,first_name,last_name,email,hire_date,job_id, manager_id, salary,commission_pct,department_id)
    VALUES
    (employees_seq.NEXTVAL,p_fname,p_lname,p_email,TRUNC(SYSDATE),p_jobid,p_mgr,p_sal,p_comm,p_dpid);
    ELSE
    raise_application_error(-20023, 'Wrong department_id');
    END IF;
END add_employee;

FUNCTION valid_deptid
      (p_deptid IN employees.department_id%TYPE)
      RETURN BOOLEAN AS
      v_valid NUMBER;
BEGIN
    SELECT department_id INTO v_valid 
    FROM departments
    WHERE department_id = p_deptid;
    RETURN TRUE;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  RETURN FALSE;
END valid_deptid;
END emp_pkg;
/
