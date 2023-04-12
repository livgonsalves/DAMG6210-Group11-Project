CREATE OR REPLACE PROCEDURE PROC_CREATE_USER (
    p_user_id IN NUMBER,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_dob IN DATE, 	
    p_phone_no IN NUMBER,
    p_email_id IN VARCHAR2,
    p_street_no IN NUMBER,
    p_street_name IN VARCHAR2,
    p_city IN VARCHAR2,
    p_state IN VARCHAR2,
    p_country IN VARCHAR2,
    p_user_type IN VARCHAR2
) IS
BEGIN
    INSERT INTO users (
        user_id,
        first_name,
        last_name,
        dob,
        phone_no, 
        email_id,
        street_no,
        street_name,
        city,
        state,
        country,
        user_type
    ) VALUES (
        p_user_id,
        p_first_name,
        p_last_name,
        p_dob,
        p_phone_no,
        p_email_id,
        p_street_no,
        p_street_name,
        p_city,
        p_state,
        p_country,
        p_user_type
    );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('New user created with ID ' || p_user_id);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
END PROC_CREATE_USER;
/

CREATE OR REPLACE PROCEDURE update_user(
    p_user_id IN NUMBER,
    p_first_name IN VARCHAR2,
    p_last_name IN VARCHAR2,
    p_dob IN DATE, 	
    p_phone_no IN NUMBER,
    p_email_id IN VARCHAR2,
    p_street_no IN NUMBER,
    p_street_name IN VARCHAR2,
    p_city IN VARCHAR2,
    p_state IN VARCHAR2,
    p_country IN VARCHAR2,
    p_user_type IN VARCHAR2
)
AS
    e_code NUMBER;
    e_msg VARCHAR2(255);
BEGIN
    UPDATE users
    SET first_name = p_first_name,
        last_name = p_last_name,
        dob = p_dob,
        phone_no = p_phone_no,
        email_id = p_email_id,
        street_no = p_street_no,
        street_name = p_street_name,
        city = p_city,
        state = p_state,
        country = p_country,
        user_type = p_user_type
    WHERE user_id = p_user_id;
    
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'User not found');
    END IF;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('User information updated successfully');
    
EXCEPTION
    WHEN OTHERS THEN
        e_code := SQLCODE;
        e_msg := SUBSTR(SQLERRM, 1, 255);
        DBMS_OUTPUT.PUT_LINE('Error ' || e_code || ': ' || e_msg);
END update_user;
/

CREATE OR REPLACE PROCEDURE delete_user(p_user_id IN NUMBER)
AS
    e_code NUMBER;
    e_msg VARCHAR2(255);
BEGIN
    DELETE FROM users WHERE user_id = p_user_id;
    
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'User not found');
    END IF;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('User deleted successfully');
    
EXCEPTION
    WHEN OTHERS THEN
        e_code := SQLCODE;
        e_msg := SUBSTR(SQLERRM, 1, 255);
        DBMS_OUTPUT.PUT_LINE('Error ' || e_code || ': ' || e_msg);
END delete_user;
/
