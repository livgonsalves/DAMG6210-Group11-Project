CREATE OR REPLACE PROCEDURE PROC_CREATE_USER (
    pi_admin_id NUMBER,
    pi_first_name VARCHAR2,
    pi_last_name VARCHAR2,
    pi_dob DATE,
    pi_phone_no NUMBER,
    pi_email_id VARCHAR2,
    pi_street_no NUMBER,
    pi_street_name VARCHAR2,
    pi_city VARCHAR2,
    pi_state_name CHAR,
    pi_country CHAR,
    pi_user_type VARCHAR2
)
IS
    v_user_id NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
BEGIN
    -- Generate a unique user ID using a sequence
    SELECT SEQ_USER_ID.NEXTVAL INTO v_user_id FROM DUAL;

    -- Insert the new user into the USERS table
    INSERT INTO USERS (
        USER_ID,
        ADMIN_ID,
        FIRST_NAME,
        LAST_NAME,
        DOB,
        PHONE_NO,
        EMAIL_ID,
        STREET_NO,
        STREET_NAME,
        CITY,
        STATE_NAME,
        COUNTRY,
        USER_TYPE
    ) VALUES (
        v_user_id,
        pi_admin_id,
        pi_first_name,
        pi_last_name,
        pi_dob,
        pi_phone_no,
        pi_email_id,
        pi_street_no,
        pi_street_name,
        pi_city,
        pi_state_name,
        pi_country,
        pi_user_type
    );

    -- Output a success message with the new user's ID
    DBMS_OUTPUT.PUT_LINE('User created with ID: ' || v_user_id);

EXCEPTION
    WHEN OTHERS THEN
        -- Output an error message with the details of the exception
        e_code := SQLCODE;
        e_msg := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Error creating user: ' || e_code || ' - ' || e_msg);
END PROC_CREATE_USER;
/

CREATE OR REPLACE PROCEDURE PROC_UPDATE_USER(
    pi_user_id NUMBER,
    pi_first_name VARCHAR2,
    pi_last_name VARCHAR2,
    pi_dob DATE,
    pi_phone_no NUMBER,
    pi_email_id VARCHAR2,
    pi_street_no NUMBER,
    pi_street_name VARCHAR2,
    pi_city VARCHAR2,
    pi_state_name CHAR(2),
    pi_country CHAR(2)
) AS
BEGIN
    UPDATE USERS
    SET FIRST_NAME = pi_first_name,
        LAST_NAME = pi_last_name,
        DOB = pi_dob,
        PHONE_NO = pi_phone_no,
        EMAIL_ID = pi_email_id,
        STREET_NO = pi_street_no,
        STREET_NAME = pi_street_name,
        CITY = pi_city,
        STATE_NAME = pi_state_name,
        COUNTRY = pi_country
    WHERE USER_ID = pi_user_id;
    
    dbms_output.put_line('User updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error occurred: ' || SQLCODE || '-' || SQLERRM);
END PROC_UPDATE_USER;

CREATE OR REPLACE PROCEDURE PROC_DELETE_USER(
    pi_user_id NUMBER
) AS
BEGIN
    DELETE FROM USERS
    WHERE USER_ID = pi_user_id;
    
    IF SQL%ROWCOUNT = 1 THEN
        dbms_output.put_line('User deleted successfully.');
    ELSE
        dbms_output.put_line('User not found.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error occurred: ' || SQLCODE || '-' || SQLERRM);
END PROC_DELETE_USER;
