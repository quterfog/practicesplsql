create or replace PACKAGE EMP_PKG AS 
    
    TYPE emp_indx IS TABLE OF employees%ROWTYPE ;
    
    PROCEDURE add_employee
    (p_fname    employees.first_name%TYPE,
    p_lname     employees.last_name%TYPE,
    p_email     employees.email%TYPE,
    p_job       employees.job_id%TYPE DEFAULT 'SA_REP',
    p_mgr       employees.manager_id%TYPE DEFAULT 145,
    p_sal       employees.salary%TYPE DEFAULT 1000,
    p_comm      employees.commission_pct%TYPE DEFAULT 0,
    p_deptid    employees.department_id%TYPE DEFAULT 30);
    
    PROCEDURE add_employee
    (p_fname    employees.first_name%TYPE,
    p_lname     employees.last_name%TYPE,
    p_deptid    employees.department_id%TYPE);
    
    
    
    PROCEDURE get_employee
    (p_emid IN employees.employee_id%TYPE,
    p_sal OUT employees.salary%TYPE,
    p_jobid OUT employees.job_id%TYPE);
    
    FUNCTION get_employee
    (p_emp_id employees.employee_id%TYPE)
    RETURN employees%ROWTYPE;
    
    FUNCTION get_employee
    (p_family_name employees.last_name%TYPE)
    RETURN employees%ROWTYPE;
    
    PROCEDURE get_employees
    (p_dept_id    employees.department_id%TYPE);
    
    PROCEDURE show_employees;
    
    FUNCTION valid_deptid  
    (p_deptid departments.department_id%TYPE) 
    RETURN BOOLEAN;
    
   PROCEDURE set_salary(p_jobid VARCHAR2, p_min_salary NUMBER);
    
    
    PROCEDURE PRINT_EMPLOYEE
    (p_emp_rec employees%ROWTYPE);
    
    PROCEDURE INIT_DEPARTMENTS;
END EMP_PKG;