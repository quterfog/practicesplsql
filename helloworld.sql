SET SERVEROUTPUT ON
DECLARE
  v_today DATE := SYSDATE;
  v_tomorrow v_today%TYPE;
BEGIN
  v_tomorrow := v_today + 1;
  dbms_output.put_line('Hello World');
  dbms_output.put_line('TODAY IS '||v_today);
  dbms_output.put_line('TOMORROW IS '||v_tomorrow);
END;