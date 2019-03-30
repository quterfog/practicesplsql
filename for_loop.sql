BEGIN
  FOR i IN 1..10 LOOP
    IF i = 6 OR i = 8 THEN NULL;
   ELSE
    INSERT INTO messages
    VALUES (i);
    END IF;
  END LOOP;
  COMMIT;
END;
/
SELECT * FROM messages;
