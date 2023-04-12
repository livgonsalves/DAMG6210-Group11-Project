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
    user_count NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
    exp_NULL_VALUE exception;
    exp_USER_EXISTS exception;

BEGIN

    if p_userid IS NULL 
    or p_streetno IS NULL
    or p_street IS NULL 
    or p_city IS NULL  
    or p_state IS NULL
    or p_country IS NULL
    then 
        raise exp_NULL_VALUE;
    end if;
    
    select count(1) into user_count from user_id where street_no=p_streetno;
    
     if user_count>0
    then
        raise exp_USER_EXISTS;
        
    else
        insert into user values(SEQ_USER_ID.nextval,p_userid, p_streetno, p_street, p_city , p_state , p_country,0,sysdate,sysdate );
        commit;
    dbms_output.put_line('New user Added'); 
    end if;


EXCEPTION

    when exp_NULL_VALUE
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');

    when exp_USER_EXISTS
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('SECTION ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
        dbms_output.put_line('---------------------------');


    WHEN OTHERS THEN
        dbms_output.put_line('Exception Occurred');  
        e_code := SQLCODE;
        e_msg := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Error Code: ' || e_code);
        dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
END;
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
)is
    user_count NUMBER;
    e_code NUMBER;
    email_id VARCHAR2;
    exp_NULL_VALUE exception;
    exp_USER_NOT_EXISTS exception;

BEGIN
    if pi_user_id IS NULL 
    or pi_street_no IS NULL 
    or pi_street_name IS NULL 
    or pi_user_city IS NULL
    or pi_user_state IS NULL
    or pi_user_country IS NULL
    then 
        raise exp_NULL_VALUE;
    end if;

    select count(1) into user_count from user where user_id=pi_user_id;
    
    if user_count>0
    then
        update user set
        user_id=pi_userid,
        user_street_no=pi_user_street_no,
        user_street_name=pi_user_street_name,
        user_city=pi_user_city,
        user_state=pi_user_state,
        user_country=pi_user_country,
        where user_id=pi_user_id;
        commit;
        dbms_output.put_line('user_id Updated');      
    else
        raise exp_USER_NOT_EXISTS;
    end if;

EXCEPTION
    when exp_NULL_VALUE
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');
        
    when exp_USER_NOT_EXISTS
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('SECTION DOES NOT EXISTS, GIVE THE CORRECT SECTION ID THAT EXISTS'); 
        dbms_output.put_line('---------------------------');

    WHEN OTHERS THEN
        dbms_output.put_line('Exception Occurred');
        e_code := SQLCODE;
        e_msg := SQLERRM;
        dbms_output.put_line('Error Code: ' || e_code);
        dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 

END;
/

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
