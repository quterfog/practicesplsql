CREATE OR REPLACE PROCEDURE del_job 
          (p_jobid jobs.job_id%TYPE)
    AS
BEGIN
    DELETE FROM jobs
    WHERE job_id = p_jobid;
    IF SQL%NOTFOUND THEN
    raise_application_error(-20203, 'No jobs deleted.');
    END IF;
END del_job;
/
EXEC del_job ('IT_WEB');
/
SELECT * FROM jobs WHERE job_id = 'IT_WEB';
SET SERVEROUTPUT ON