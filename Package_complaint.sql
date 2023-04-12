CREATE OR REPLACE PACKAGE BODY complaint_pkg AS

-- Procedure  to add a new complaint to the complaint table 
 -- This procedure takes in the user ID, meter ID, complaint description, and complaint status as input parameters
 PROCEDURE add_complaint (
    p_user_id NUMBER,
    p_meter_id NUMBER,
    p_complaint_desc VARCHAR2,
    p_complaint_status VARCHAR2
  ) IS
  BEGIN
    INSERT INTO COMPLAINT (COMPLAINT_ID, USER_ID, METER_ID, COMPLAINT_DESC, COMPLAINT_STATUS)
    VALUES (SEQ_COMPLAINT_ID.NEXTVAL, p_user_id, p_meter_id, p_complaint_desc, p_complaint_status);
  END add_complaint;
  
  -- Procedure  to update complaint status in complaint table 
  -- This procedure takes in the complaint ID and the new complaint status as input parameters
   PROCEDURE update_complaint_status (
    p_complaint_id NUMBER,
    p_complaint_status VARCHAR2
  ) IS
  BEGIN
    UPDATE COMPLAINT
    SET COMPLAINT_STATUS = p_complaint_status
    WHERE COMPLAINT_ID = p_complaint_id;
  END update_complaint_status;
  
  -- Trigger to log updates to complaint status
 CREATE OR REPLACE TRIGGER complaint_status_update_trg
 AFTER UPDATE ON COMPLAINT
 FOR EACH ROW
 BEGIN
    IF :OLD.COMPLAINT_STATUS <> :NEW.COMPLAINT_STATUS THEN
      INSERT INTO DUAL (COMPLAINT_ID, OLD_STATUS, NEW_STATUS, UPDATED_BY, UPDATED_AT)
      VALUES (:OLD.COMPLAINT_ID, :OLD.COMPLAINT_STATUS, :NEW.COMPLAINT_STATUS, USER, to_date(SYSDATE));
    END IF;
  END complaint_status_update_trg;
  
  
  -- Procedure  to fetch user complaints in complaint table
  -- This function takes in the user ID as an input parameter

  CREATE or FUNCTION get_user_complaints (
    p_user_id NUMBER
  ) RETURN SYS_REFCURSOR IS
    user_complaints SYS_REFCURSOR;
  BEGIN
    OPEN user_complaints FOR
      SELECT *
      FROM COMPLAINT
      WHERE USER_ID = p_user_id;
    RETURN user_complaints;
  END get_user_complaints;

  
END complaint_pkg;
/
 
 
 
 --Adding new complaint record
 BEGIN
  complaint_pkg.add_complaint(1234, 5678, 'My meter is not working', 'OPEN');
END;

--updating status of a complaint record.
BEGIN
  complaint_pkg.update_complaint_status(123, 'CLOSED');
END;