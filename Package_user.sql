
CREATE OR REPLACE PROCEDURE create_user(
  user_id IN VARCHAR2,
  first_name IN VARCHAR2,
  last_name IN VARCHAR2,
  email IN VARCHAR2,
  phone_no IN VARCHAR2,
  street IN VARCHAR2,
  city IN VARCHAR2,
  state IN VARCHAR2,
  country IN VARCHAR2
)
AS
BEGIN
  INSERT INTO users (
    user_id,
    first_name,
    last_name,
    email,
    phone_no,
    street,
    city,
    state,
    country
  ) VALUES (
    user_id,
    first_name,
    last_name,
    email,
    phone_no,
    street,
    city,
    state,
    country
  );
  COMMIT;
END create_user;

CREATE OR REPLACE PROCEDURE update_user(
  user_id IN VARCHAR2,
  email IN VARCHAR2,
  phone_no IN VARCHAR2,
  address IN VARCHAR2
)
AS
BEGIN
  UPDATE users
  SET
    email = update_user.email,
    phone_no = update_user.phone_no,
    address = update_user.address
  WHERE user_id = update_user.user_id;
  COMMIT;
END update_user;

CREATE OR REPLACE PROCEDURE delete_user(
  user_id IN VARCHAR2
)
AS
BEGIN
  DELETE FROM users WHERE user_id = delete_user.user_id;
  COMMIT;
END delete_user;

CREATE OR REPLACE PROCEDURE inactivate_user(
  user_id IN VARCHAR2
)
AS
BEGIN
  UPDATE users SET active = 0 WHERE user_id = inactivate_user.user_id;
  COMMIT;
END inactivate_user;

CREATE OR REPLACE PROCEDURE is_user_active(
  user_id IN VARCHAR2,
  is_active OUT NUMBER
)
AS
BEGIN
  SELECT active INTO is_active FROM users WHERE user_id = is_user_active.user_id;
END is_user_active;

CREATE OR REPLACE PROCEDURE get_user_registration(
  first_name IN VARCHAR2,
  last_name IN VARCHAR2,
  email IN VARCHAR2,
  user_details OUT SYS_REFCURSOR
)
AS
BEGIN
  OPEN user_details FOR 
    SELECT * FROM users 
    WHERE first_name = get_user_registration.first_name 
    AND last_name = get_user_registration.last_name 
    AND email = get_user_registration.email;
END get_user_registration;








create or replace procedure 
add_meterboard(
    p_userid number, p_meterstreetno number,p_meterstreet varchar, p_metercity varchar, p_meterstate varchar, p_metercountry varchar
) is
    metercount NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
    exp_NULL_VALUE exception;
    exp_METER_EXISTS exception;
begin

    if p_userid IS NULL 
    or p_meterstreetno IS NULL
    or p_meterstreet IS NULL 
    or p_metercity IS NULL  
    or p_meterstate IS NULL
    or p_metercountry IS NULL
    then 
        raise exp_NULL_VALUE;
    end if;
    
    select count(1) into metercount from meterboard where meter_street_no=p_meterstreetno;
    
     if metercount>0
    then
        raise exp_METER_EXISTS;
        
    else
        insert into meterboard values(SEQ_METER_ID.nextval,p_userid, p_meterstreetno, p_meterstreet, p_metercity , p_meterstate , p_metercountry,0,sysdate,sysdate );
        commit;
    dbms_output.put_line('New meter Added'); 
    end if;
    
        
exception

    when exp_NULL_VALUE
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');

    when exp_METER_EXISTS
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('SECTION ALREADY EXISTS, ASSIGN A NAME THAT IS NOT USED ALREADY'); 
        dbms_output.put_line('---------------------------');
    
    when others
    then 
        dbms_output.put_line('Exception Occurred');
        e_code := SQLCODE;
        e_msg := SQLERRM;
        dbms_output.put_line('Error Code: ' || e_code);
        dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
    
end;
/



