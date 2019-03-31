create or replace TRIGGER DELETE_EMP_TRG 
BEFORE DELETE ON EMPLOYEES 
BEGIN
  IF (TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')) 
  OR (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '09:00' AND '18:00') THEN 
  RAISE_APPLICATION_ERROR (-20202 ,'Employee records cannot be deleted during the business hours of 9AM and 6PM');
  END IF;
END;