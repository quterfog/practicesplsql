CREATE OR REPLACE PACKAGE dsql_pkg AS
  PROCEDURE make (p_table_name VARCHAR2, p_col_specs VARCHAR2);
  PROCEDURE add_row (p_table_name VARCHAR2, p_col_values VARCHAR2, p_cols VARCHAR2 := NULL);
  PROCEDURE upd_row (p_table_name VARCHAR2, p_set_values VARCHAR2, p_conditions VARCHAR2 := NULL);
  PROCEDURE del_row (p_table_name VARCHAR2, p_condition VARCHAR2 := NULL);
  PROCEDURE remove (p_table_name VARCHAR2);
END dsql_pkg;
/

CREATE OR REPLACE PACKAGE BODY dsql_pkg IS

      PROCEDURE make (p_table_name VARCHAR2, p_col_specs VARCHAR2)
      IS 
      BEGIN
      EXECUTE IMMEDIATE 'CREATE TABLE '||p_table_name||' ('||p_col_specs||')';
      END make;
      
      PROCEDURE add_row (p_table_name VARCHAR2, p_col_values VARCHAR2, p_cols VARCHAR2 := NULL)
      IS
      BEGIN
      IF p_cols IS NULL THEN 
      EXECUTE IMMEDIATE 'INSERT INTO '||p_table_name||' VALUES '||'('||p_col_values||')';
      ELSE EXECUTE IMMEDIATE 'INSERT INTO '||p_table_name||' ('||p_cols||') VALUES '||'('||p_col_values||')';
      END IF;
  END add_row;

  PROCEDURE upd_row (p_table_name VARCHAR2, p_set_values VARCHAR2, p_conditions VARCHAR2 := NULL) IS
  BEGIN
  IF p_conditions IS NULL THEN
    EXECUTE IMMEDIATE 'UPDATE '||p_table_name||' SET '||p_set_values;
  ELSE 
    EXECUTE IMMEDIATE 'UPDATE '||p_table_name||' SET '||p_set_values||' WHERE '||p_conditions;
  END IF;
END upd_row;

PROCEDURE del_row (p_table_name VARCHAR2, p_condition VARCHAR2 := NULL)
      AS
BEGIN
    IF p_condition IS NULL THEN
        EXECUTE IMMEDIATE 'DELETE FROM '||p_table_name;
    ELSE
        EXECUTE IMMEDIATE 'DELETE FROM '||p_table_name||' WHERE '||p_condition;
    END IF;
END del_row;

  PROCEDURE remove (p_table_name VARCHAR2)
  AS
  BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE '||p_table_name;
  END remove;
END dsql_pkg;
/
  

  