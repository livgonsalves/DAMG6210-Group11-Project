
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
            pi_billing_start_date DATE, 
            pi_billing_end_date DATE,
            pi_units_used FLOAT,
            pi_payment_type VARCHAR,
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
            exp_USER_ACTIVE exception;
            --exp_USER NOT_ACTIVE exception;
           
    BEGIN
            IF pi_billing_amt IS NULL
            OR pi_billing_start_date IS NULL
            OR pi_billing_end_date IS NULL
            OR pi_units_used IS NULL
            OR pi_payment_type IS NULL
            OR pi_billing_amt IS NULL
            OR pi_due_date IS NULL
        THEN
            RAISE exp_NULL_VALUE;
        END IF;
       
       SELECT count(1) into userCount FROM billing where user_id=pi_user_id;
       
       IF userCount > 1 
       THEN 
       RAISE exp_USER_ACTIVE;
       ELSE 
       INSERT INTO billing VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.nextval, SEQ_METER_ID.nextval, pi_billing_start_date,pi_billing_end_date,pi_units_used, pi_payment_type, pi_payment_status, pi_service_charge, pi_dist_charge, pi_due_date,  pi_billing_amt);
    dbms_output.put_line('NEW BILLING ENTRY INSERTED');
       END IF;
       
    EXCEPTION 
        when exp_NULL_VALUE
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        when exp_USER_ACTIVE
        then
                dbms_output.new_line;
                dbms_output.put_line('---------------------------');
                dbms_output.put_line('Cannot add a user, thats already existing'); 
END;
/
           
