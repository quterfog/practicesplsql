SET SERVEROUTPUT ON
DECLARE
  v_today DATE := SYSDATE;
  v_tomorrow v_today%TYPE;
  v_name VARCHAR2 := 'Alexandr';
BEGIN
  v_tomorrow := v_today + 1;
  dbms_output.put_line('Hello World');
  dbms_output.put_line('MY NAME IS '||v_name);
  dbms_output.put_line('TODAY IS '||v_today);
  dbms_output.put_line('TOMORROW IS '||v_tomorrow);
END;