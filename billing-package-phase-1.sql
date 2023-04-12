
-- CREATE SEQUENCE CODE VERSION - 1

create or replace procedure
PROC_EBMS_SEQUENCE_SETUP
as
    seqCount NUMBER;
    seqName VARCHAR(255);
    e_code NUMBER;
    e_msg VARCHAR(255);
begin

    seqName:='SEQ_BILLING_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName;
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 100';

exception
when others
    then dbms_output.put_line('Exception Occurred');
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
end;
/

begin
    PROC_EBMS_SEQUENCE_SETUP;
end;
/


CREATE OR REPLACE PROCEDURE
        PROC_INSERT_BILL(
            pi_user_id NUMBER,
            pi_meter_id NUMBER,
            pi_billing_start_date DATE, 
            pi_billing_end_date DATE,
            pi_units_used FLOAT,
            pi_payment_status VARCHAR,
            pi_service_charge FLOAT,
            pi_dist_charge FLOAT,
            pi_due_date DATE,
            pi_billing_amt FLOAT
        ) IS
            userCount NUMBER ;
            e_code NUMBER;
            e_msg VARCHAR2(255);
            exp_NULL_VALUE exception;
            exp_USER_INACTIVE exception;
            --exp_USER NOT_ACTIVE exception;
           
    BEGIN
            IF pi_billing_amt IS NULL
            OR pi_billing_start_date IS NULL
            OR pi_billing_end_date IS NULL
            OR pi_units_used IS NULL
            OR pi_billing_amt IS NULL
            OR pi_due_date IS NULL
            OR pi_meter_id IS NULL
            OR pi_user_id IS NULL
        THEN
            RAISE exp_NULL_VALUE;
        END IF;
       
       SELECT count(1) into userCount FROM billing where user_id=pi_user_id;
       
       IF userCount > 0 
       THEN 
       INSERT INTO billing VALUES (SEQ_BILLING_ID.nextval, pi_user_id, pi_meter_id, pi_billing_start_date,pi_billing_end_date,pi_units_used,'' , pi_payment_status, pi_service_charge, pi_dist_charge, pi_due_date,  pi_billing_amt);
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
/

create or replace procedure 
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
/




   
           