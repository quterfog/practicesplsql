CREATE OR REPLACE FUNCTION valid_deptid
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
/
EXEC valid_deptid(30);