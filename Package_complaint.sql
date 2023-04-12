CREATE OR REPLACE PACKAGE complaint_pkg AS 
    PROCEDURE add_complaint (
    p_user_id NUMBER,
    p_meter_id NUMBER,
    p_complaint_desc VARCHAR2,
    p_complaint_status VARCHAR2
  ) ;
    PROCEDURE update_complaint_status (
    p_complaint_id NUMBER,
    p_complaint_status VARCHAR2
  ) ;
  FUNCTION get_user_complaints (
    p_complaint_id NUMBER
  )RETURN VARCHAR2;
  
  END complaint_pkg;
    
  
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
  
  
  -- Procedure  to fetch user complaints in complaint table
  -- This function takes in the user ID as an input parameter
FUNCTION get_user_complaints (
    p_complaint_id NUMBER
  ) RETURN VARCHAR2 IS
    v_complaint_desc VARCHAR2(255);
  BEGIN
      SELECT complaint_desc into v_complaint_desc
      FROM COMPLAINT
      WHERE complaint_id = p_complaint_id;
    RETURN v_complaint_desc;
  END get_user_complaints;


  
END complaint_pkg;
/
 
 
 
 --Adding new complaint record
 BEGIN
  complaint_pkg.add_complaint(2, 102, 'My meter is not working', 'OPEN');
END;

--updating status of a complaint record.
BEGIN
  complaint_pkg.update_complaint_status(10005, 'CLOSED');
END;


DECLARE
complaint_out VARCHAR2 (255);
BEGIN 
complaint_out := complaint_pkg.get_user_complaints(10021);
DBMS_OUTPUT.PUT_LINE('Complaint Desc: ' || complaint_out );
END;
