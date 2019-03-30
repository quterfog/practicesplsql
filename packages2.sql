CREATE OR REPLACE PACKAGE job_pkg AS
    PROCEDURE add_job (p_jobid VARCHAR2, p_jobtitle VARCHAR);
    PROCEDURE upd_job (p_jobid    VARCHAR2, p_jtitle  VARCHAR2);
    PROCEDURE del_job (p_jobid jobs.job_id%TYPE);
    FUNCTION get_job (p_jobid IN jobs.job_id%TYPE) RETURN VARCHAR2;
END job_pkg;
/
CREATE OR REPLACE PACKAGE BODY job_pkg AS
    PROCEDURE add_job 
          (p_jobid VARCHAR2,
          p_jobtitle VARCHAR)
          AS
        BEGIN
            INSERT INTO jobs (job_id, job_title) 
            VALUES (p_jobid, p_jobtitle);
    END add_job;
    
    PROCEDURE del_job 
          (p_jobid jobs.job_id%TYPE)
    AS
BEGIN
    DELETE FROM jobs
    WHERE job_id = p_jobid;
    IF SQL%NOTFOUND THEN
    raise_application_error(-20203, 'No jobs deleted.');
    END IF;
END del_job;

PROCEDURE upd_job
      (p_jobid  VARCHAR2,
      p_jtitle  VARCHAR2)
  AS
BEGIN
  UPDATE jobs
  SET job_title = p_jtitle
  WHERE job_id = p_jobid;
  IF SQL%NOTFOUND THEN
    raise_application_error(-20202, 'No job updated.');
  END IF;
END upd_job;

FUNCTION get_job
        (p_jobid IN jobs.job_id%TYPE)
        RETURN VARCHAR2 IS
    v_jobtitle  jobs.job_title%TYPE;
BEGIN
    SELECT job_title INTO v_jobtitle
    FROM jobs
    WHERE job_id = p_jobid;
    RETURN v_jobtitle;
END get_job;

END job_pkg;
