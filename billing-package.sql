CREATE OR REPLACE PACKAGE billing_pkg AS 
       PROCEDURE PROC_INSERT_BILL(
            pi_user_id NUMBER,
            pi_meter_id NUMBER, 
            pi_billing_end_date DATE,
            pi_units_used FLOAT,
            pi_payment_status VARCHAR,
            pi_service_charge FLOAT,
            pi_dist_charge FLOAT
       );
       PROCEDURE PROC_UPDATE_BILLING(
       pi_billing_id number, 
       pi_payment_type varchar
       );
  
  END billing_pkg;



CREATE OR REPLACE PACKAGE BODY billing_pkg AS

PROCEDURE
        PROC_INSERT_BILL(
            pi_user_id NUMBER,
            pi_meter_id NUMBER, 
            pi_billing_end_date DATE,
            pi_units_used FLOAT,
            pi_payment_status VARCHAR,
            pi_service_charge FLOAT,
            pi_dist_charge FLOAT
        ) IS
            v_start_date DATE;
            v_due_date DATE;
            userCount NUMBER ;
            e_code NUMBER;
            e_msg VARCHAR2(255);
            exp_NULL_VALUE exception;
            exp_USER_INACTIVE exception;
            --exp_USER NOT_ACTIVE exception;
              
           
    BEGIN
            IF pi_billing_end_date IS NULL
            OR pi_units_used IS NULL
            OR pi_meter_id IS NULL
            OR pi_user_id IS NULL
        THEN
            RAISE exp_NULL_VALUE;
        END IF;
       
       SELECT count(1) into userCount FROM billing where user_id=pi_user_id;
       
       IF userCount > 0 
       THEN 
       v_start_date := ADD_MONTHS(pi_billing_end_date,-1);
       v_due_date := ADD_MONTHS(pi_billing_end_date,1);
       INSERT INTO billing VALUES (SEQ_BILLING_ID.nextval, pi_user_id, pi_meter_id, v_start_date,pi_billing_end_date,pi_units_used,'' , pi_payment_status, pi_service_charge, pi_dist_charge, v_due_date, pi_service_charge+pi_dist_charge);
         dbms_output.put_line('NEW BILLING ENTRY INSERTED');
        ELSE
        RAISE exp_USER_INACTIVE;
       
       END IF;
       
    EXCEPTION 
        when exp_NULL_VALUE
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        when exp_USER_INACTIVE
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('USER DOESNT EXIST'); 
END;

PROCEDURE
PROC_UPDATE_BILLING(pi_billing_id number, pi_payment_type varchar
    ) is 
    billingcount NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
    exp_NULL_VALUE exception;
    exp_BILLING_NOT_EXISTS exception;
begin

    if pi_billing_id IS NULL     
    then 
        raise exp_NULL_VALUE;
    end if;

    select count(1) into billingcount from billing where billing_id=pi_billing_id;
    
    if billingcount>0
    then
        if pi_payment_type is null
        then
        update billing set
        payment_status='PENDING'
        where billing_id=pi_billing_id;
        commit;
        else
        update billing set
        payment_type=pi_payment_type,
        payment_status='PAID'
        where billing_id=pi_billing_id;
        commit;
        end if;
    else
        raise exp_BILLING_NOT_EXISTS;
    end if;

    
exception

    when exp_NULL_VALUE
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');
        
    when exp_BILLING_NOT_EXISTS
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('SECTION DOES NOT EXISTS, GIVE THE CORRECT SECTION ID THAT EXISTS'); 
        dbms_output.put_line('---------------------------');
       

    when others
    then 
        dbms_output.put_line('Exception Occurred');
        e_code := SQLCODE;
        e_msg := SQLERRM;
        dbms_output.put_line('Error Code: ' || e_code);
        dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
    
end;


END billing_pkg;


/


BEGIN
  PROC_INSERT_BILL( 2,
            102,
            sysdate, 
            400.00,
            'PENDING',
            40.00,
            50.00
            );
END;

--updating status of a complaint record.
BEGIN
  PROC_UPDATE_BILLING(1013, 'MOBILE PAYMENTS');
END;

--select *from billing;
