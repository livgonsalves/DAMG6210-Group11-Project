
SET SERVEROUTPUT ON;



CREATE OR REPLACE PACKAGE insert_complaint_pkg AS 
    PROCEDURE add_complaint (
    p_user_id NUMBER,
    p_meter_id NUMBER,
    p_complaint_desc VARCHAR2,
    p_complaint_status VARCHAR2
  ) ;

  END insert_complaint_pkg;
    
/

CREATE OR REPLACE PACKAGE update_complaint_pkg AS 
    PROCEDURE update_complaint_status (
    p_complaint_id NUMBER,
    p_complaint_status VARCHAR2
  ) ; 
  
    END update_complaint_pkg;
  /
CREATE OR REPLACE PACKAGE BODY insert_complaint_pkg AS

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
    
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('');
            dbms_output.put_line('Complaint Added Successfully');
            dbms_output.put_line('');
            dbms_output.put_line('---------------------------');
            
  END add_complaint;

  -- Procedure  to update complaint status in complaint table 
  -- This procedure takes in the complaint ID and the new complaint status as input parameters

  
END insert_complaint_pkg;
/

CREATE OR REPLACE PACKAGE BODY update_complaint_pkg AS
PROCEDURE update_complaint_status (
    p_complaint_id NUMBER,
    p_complaint_status VARCHAR2
  ) IS
  BEGIN
    UPDATE COMPLAINT
    SET COMPLAINT_STATUS = p_complaint_status,
        UPDATED_BY = user,
        UPDATED_AT = sysdate
    WHERE COMPLAINT_ID = p_complaint_id;
    
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('');
            dbms_output.put_line('Complaint Status Updated Successfully');
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('');
            
  END update_complaint_status;
  
  END update_complaint_pkg;
  /
 
 
 --SELECT * FROM COMPLAINT;
 
 
 --Test Cases
 --Adding new complaint record
 BEGIN
  insert_complaint_pkg.add_complaint(16, 121, 'My meter is switched off', 'OPEN');
END;

--updating status of a complaint record.
BEGIN
  update_complaint_pkg.update_complaint_status(10002, 'Closed');
END;



 
  
  
