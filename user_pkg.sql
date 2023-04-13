SET SERVEROUTPUT ON;


CREATE OR REPLACE PACKAGE users_pkg AS 
    PROCEDURE add_user (
    p_admin_id NUMBER,
    p_first_name VARCHAR2,
    p_last_name VARCHAR2,
    p_dob DATE,
    p_phone_no NUMBER,
    p_email_id VARCHAR2,
    p_street_no NUMBER,
    p_street_name VARCHAR2,
    p_city VARCHAR2,
    p_state_name CHAR,
    p_country CHAR,
    p_user_type VARCHAR2
  );

    PROCEDURE update_user (
    p_user_id NUMBER,
    p_first_name VARCHAR2,
    p_last_name VARCHAR2,
    p_dob DATE,
    p_phone_no NUMBER,
    p_email_id VARCHAR2,
    p_street_no NUMBER,
    p_street_name VARCHAR2,
    p_city VARCHAR2,
    p_state_name CHAR,
    p_country CHAR
  );
  
  PROCEDURE delete_user (
    p_user_id NUMBER
  );
  
   FUNCTION get_user_info (
    p_user_id NUMBER
  ) RETURN VARCHAR2;

  END users_pkg;

/
  
CREATE OR REPLACE PACKAGE BODY users_pkg AS

  -- Procedure to add a new user to the users table
  -- This procedure takes in the admin ID, first name, last name, date of birth, phone number, email, street number, street name, city, state, country, and user type as input parameters
    PROCEDURE add_user (
        p_admin_id    NUMBER,
        p_first_name  VARCHAR2,
        p_last_name   VARCHAR2,
        p_dob         DATE,
        p_phone_no    NUMBER,
        p_email_id    VARCHAR2,
        p_street_no   NUMBER,
        p_street_name VARCHAR2,
        p_city        VARCHAR2,
        p_state_name  CHAR,
        p_country     CHAR,
        p_user_type   VARCHAR2
    ) IS
        usercount NUMBER;
        e_code    NUMBER;
        e_msg     VARCHAR2(255);
        exp_null_value EXCEPTION;
        exp_user_exists EXCEPTION;
    BEGIN
        IF p_admin_id IS NULL OR p_first_name IS NULL OR p_last_name IS NULL OR p_dob IS NULL OR p_phone_no IS NULL OR p_email_id IS NULL
        OR p_street_no IS NULL OR p_street_name IS NULL OR p_city IS NULL OR p_state_name IS NULL OR p_country IS NULL OR p_user_type
        IS NULL THEN
            RAISE exp_null_value;
        END IF;

        SELECT
            COUNT(1)
        INTO usercount
        FROM
            users
        WHERE
            email_id = p_email_id;

        IF usercount > 0 THEN
            RAISE exp_user_exists;
        ELSE
            INSERT INTO users (
                user_id,
                admin_id,
                first_name,
                last_name,
                dob,
                phone_no,
                email_id,
                street_no,
                street_name,
                city,
                state_name,
                country,
                user_type
            ) VALUES (
                seq_user_id.NEXTVAL,
                p_admin_id,
                p_first_name,
                p_last_name,
                p_dob,
                p_phone_no,
                p_email_id,
                p_street_no,
                p_street_name,
                p_city,
                p_state_name,
                p_country,
                p_user_type
            );

            COMMIT;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('New User Added Successfully');
            dbms_output.put_line('---------------------------');
        END IF;

    EXCEPTION
        WHEN exp_null_value THEN
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES');
            dbms_output.put_line('---------------------------');
        WHEN exp_user_exists THEN
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('USER ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY');
            dbms_output.put_line('---------------------------');
        WHEN OTHERS THEN
            dbms_output.put_line('Exception Occurred');
            e_code := sqlcode;
            e_msg := sqlerrm;
            dbms_output.put_line('Error Code: ' || e_code);
            dbms_output.put_line('Error Message: '
                                 || substr(e_msg, 1, 255));
    END;
  
 -- Procedure to update user information in the userstable
-- This procedure takes in the user ID, first name, last name, date of birth, phone number, email, street number, street name, city, state, country, and user type as input parameters
    PROCEDURE update_user (
        p_user_id     NUMBER,
        p_first_name  VARCHAR2,
        p_last_name   VARCHAR2,
        p_dob         DATE,
        p_phone_no    NUMBER,
        p_email_id    VARCHAR2,
        p_street_no   NUMBER,
        p_street_name VARCHAR2,
        p_city        VARCHAR2,
        p_state_name  CHAR,
        p_country     CHAR
    ) IS
        usercount NUMBER;
        e_code    NUMBER;
        e_msg     VARCHAR2(255);
        exp_null_value EXCEPTION;
        exp_user_not_exists EXCEPTION;
    BEGIN
        IF p_user_id IS NULL OR p_first_name IS NULL OR p_last_name IS NULL OR p_dob IS NULL OR p_phone_no IS NULL OR p_email_id IS NULL
        OR p_street_no IS NULL OR p_street_name IS NULL OR p_city IS NULL OR p_state_name IS NULL OR p_country IS NULL THEN
            RAISE exp_null_value;
        END IF;

        SELECT
            COUNT(1)
        INTO usercount
        FROM
            users
        WHERE
            user_id = p_user_id;

        IF usercount > 0 THEN
            UPDATE users
            SET
                first_name = p_first_name,
                last_name = p_last_name,
                dob = p_dob,
                phone_no = p_phone_no,
                email_id = p_email_id,
                street_no = p_street_no,
                street_name = p_street_name,
                city = p_city,
                state_name = p_state_name,
                country = p_country
            WHERE
                user_id = p_user_id;

            COMMIT;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('User Updated Successfully');
            dbms_output.put_line('---------------------------');
        ELSE
            RAISE exp_user_not_exists;
        END IF;

    EXCEPTION
        WHEN exp_null_value THEN
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES');
            dbms_output.put_line('---------------------------');
        WHEN exp_user_not_exists THEN
            dbms_output.new_line;
            dbms_output.put_line('---------------------------');
            dbms_output.put_line('USER DOES NOT EXISTS, GIVE THE CORRECT ID THAT EXISTS');
            dbms_output.put_line('---------------------------');
        WHEN OTHERS THEN
            dbms_output.put_line('Exception Occurred');
            e_code := sqlcode;
            e_msg := sqlerrm;
            dbms_output.put_line('Error Code: ' || e_code);
            dbms_output.put_line('Error Message: '
                                 || substr(e_msg, 1, 255));
    END;

  
  
-- Procedure to delete a user from the users table
-- This procedure takes in the user ID and user_email as an input parameter
       PROCEDURE delete_user (
         p_user_id NUMBER
       ) IS
    usercount NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
    exp_NULL_VALUE exception;
    exp_USER_NOT_EXISTS exception;
    
BEGIN 
    
    IF p_user_id IS NULL
    then 
        raise exp_NULL_VALUE;
    end if;
    
    select count(1) into usercount from users where user_id=p_user_id;
        if usercount>0
    then
       DELETE FROM users
       WHERE USER_ID = p_user_id;
       commit;
       dbms_output.put_line('---------------------------');
       dbms_output.put_line('User Deleted Succesfully');  
       dbms_output.put_line('---------------------------');
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
        dbms_output.put_line('USER DOES NOT EXISTS, GIVE THE CORRECT USER ID THAT EXISTS'); 
        dbms_output.put_line('---------------------------');
       

    when others
    then 
        dbms_output.put_line('Exception Occurred');
        e_code := SQLCODE;
        e_msg := SQLERRM;
        dbms_output.put_line('Error Code: ' || e_code);
        dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
    
    END;

-- Function to get a user's information from the users table
-- This function takes in the user ID as an input parameter and returns the user's first name, last name, phone number, email, street number, street name, city, state, country, and user type as a VARCHAR2
FUNCTION get_user_info (
     p_user_id NUMBER
    ) RETURN VARCHAR2 IS
    v_user_info VARCHAR2(500);
    BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME || ', ' || PHONE_NO || ', ' || EMAIL_ID || ', ' || STREET_NO || ' ' || STREET_NAME || ', ' || CITY || ', ' || STATE_NAME || ', ' || COUNTRY || ', ' || USER_TYPE
    INTO v_user_info
    FROM users
    WHERE USER_ID = p_user_id;
    RETURN v_user_info;
    END get_user_info;


END users_pkg;

/
--Test case
begin
users_pkg.add_user (
    100000,
    'Manunee',
    'Dave',
    sysdate ,
    5678904321,
    'mdave@example.com',
    16,
    'Westland Ave',
    'Cambridge',
    'MA',
    'US',
    'MAINTENANCE STAFF'
  ) ;
end;
/

begin
users_pkg.update_user (
   14,
   'Manunee',
   'Jones',
   '07-OCT-1999',
    5678904321,
   'mdave@example.com',
    16,
   'Westland Ave',
   'Cambridge',
   'MA',
   'US'
);
end;

/
begin
users_pkg.delete_user(14);
end;
/ 

SELECT (users_pkg.get_user_info(14)) Selected_User_Information from dual;

/

--SELECT * FROM users;
   
  

   
  
