create or replace PACKAGE BODY EMP_PKG AS
    TYPE boolean_tab_type IS TABLE OF BOOLEAN
    INDEX BY BINARY_INTEGER;
    valid_departments boolean_tab_type;
    emp_table emp_indx;
    
  PROCEDURE add_employee
    (p_fname    employees.first_name%TYPE,
    p_lname     employees.last_name%TYPE,
    p_email     employees.email%TYPE,
    p_job       employees.job_id%TYPE DEFAULT 'SA_REP',
    p_mgr       employees.manager_id%TYPE DEFAULT 145,
    p_sal       employees.salary%TYPE DEFAULT 1000,
    p_comm      employees.commission_pct%TYPE DEFAULT 0,
    p_deptid    employees.department_id%TYPE DEFAULT 30) AS
    PROCEDURE audit_newemp AS
            PRAGMA AUTONOMOUS_TRANSACTION;
            user_id VARCHAR2(30) := USER;
        BEGIN
            INSERT INTO log_newemp 
            (entry_id, user_id, log_time, name)
            VALUES 
            (log_newemp_seq.NEXTVAL, user_id, SYSDATE, p_fname||' '||p_lname);
            COMMIT;
        END audit_newemp;
    
  BEGIN
  
   IF valid_deptid(p_deptid) THEN
   audit_newemp;
    INSERT INTO employees (employee_id, first_name, last_name, email,
    job_id, manager_id, hire_date, salary, commission_pct, department_id)
    VALUES (EMPLOYEES_SEQ.nextval,p_fname,p_lname,p_email,p_job,p_mgr,
    TRUNC(SYSDATE), p_sal,p_comm,p_deptid);
    ELSE
    RAISE_APPLICATION_ERROR (-20204, 'Invalid department ID. Try again.');
    END IF;
  END add_employee;

  PROCEDURE get_employee
    (p_emid IN employees.employee_id%TYPE,
    p_sal OUT employees.salary%TYPE,
    p_jobid OUT employees.job_id%TYPE) AS
  BEGIN
     SELECT salary, job_id INTO p_sal,p_jobid
  FROM employees
  WHERE employee_id = p_emid;
  END get_employee;
  
  PROCEDURE show_employees AS 
  BEGIN 
  IF emp_table IS NOT NULL THEN
  DBMS_OUTPUT.PUT_LINE('Employees in Package table');
  FOR i IN 1..emp_table.COUNT LOOP
  print_employee(emp_table(i));
  END LOOP;
  END IF;
  END show_employees;
  
  FUNCTION get_employee(p_emp_id employees.employee_id%type)
    return employees%rowtype IS
    rec_emp employees%rowtype;
  BEGIN
    SELECT * INTO rec_emp
    FROM employees
    WHERE employee_id = p_emp_id;
    RETURN rec_emp;
  END get_employee;
    
     FUNCTION get_employee
    (p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE AS
    rec_emp  employees%ROWTYPE;
    BEGIN
    SELECT * INTO rec_emp
    FROM employees WHERE last_name = p_family_name;
    RETURN rec_emp;
    END get_employee;
    
  FUNCTION valid_deptid  
    (p_deptid departments.department_id%TYPE) 
    RETURN BOOLEAN AS
    v_dummy PLS_INTEGER;
  BEGIN
    RETURN valid_departments.exists(p_deptid);
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN FALSE;
  END valid_deptid;
  
  PROCEDURE add_employee
  (p_fname    employees.first_name%TYPE,
    p_lname     employees.last_name%TYPE,
    p_deptid    employees.department_id%TYPE)
    AS
    p_email     employees.email%TYPE;
    BEGIN
    p_email := UPPER(SUBSTR(p_fname,1,1)||SUBSTR(p_lname,1,7));
    add_employee(p_fname,p_lname,p_email,p_deptid=>p_deptid);
    END add_employee;
    
    PROCEDURE get_employees 
    (p_dept_id    employees.department_id%TYPE) AS
    BEGIN
    SELECT * BULK COLLECT INTO emp_table FROM employees 
    WHERE department_id = p_dept_id;
    END get_employees;
    
    PROCEDURE set_salary(p_jobid VARCHAR2, p_min_salary NUMBER) IS
    CURSOR cur_emp IS
      SELECT employee_id
      FROM employees
      WHERE job_id = p_jobid AND salary < p_min_salary;
  BEGIN
    FOR rec_emp IN cur_emp
    LOOP
      UPDATE employees
        SET salary = p_min_salary
      WHERE employee_id = rec_emp.employee_id;
    END LOOP;
  END set_salary;

    
    
    PROCEDURE PRINT_EMPLOYEE
    (p_emp_rec employees%ROWTYPE) AS
    BEGIN
    dbms_output.put_line 
                    (p_emp_rec.department_id||' '||
                    p_emp_rec.employee_id||' '||
                    p_emp_rec.first_name||' '||
                    p_emp_rec.last_name||' '||
                    p_emp_rec.job_id||' '||
                    p_emp_rec.salary);
    END PRINT_EMPLOYEE;
    
    
    
    PROCEDURE INIT_DEPARTMENTS
    AS
    BEGIN
        FOR rec IN (SELECT department_id FROM departments) LOOP
        valid_departments(rec.department_id):= TRUE;
        END LOOP;
    END INIT_DEPARTMENTS;
    
    BEGIN
    INIT_DEPARTMENTS;

END EMP_PKG;