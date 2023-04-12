create or replace procedure
PROC_EBS_SEQUENCE
as
    seqCount NUMBER;
    seqName VARCHAR(255);
    e_code NUMBER;
    e_msg VARCHAR(255);
begin

    seqName:='SEQ_METER_ID';
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
    PROC_EBS_SEQUENCE;
end;
/



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
 
create or replace procedure 
PROC_UPDATE_METER(
    p_meterid NUMBER,
    p_userid number, p_meterstreetno number,p_meterstreet varchar, p_metercity varchar, p_meterstate varchar, p_metercountry varchar, p_unitsused number) is 
    metercount NUMBER;
    e_code NUMBER;
    e_msg VARCHAR2(255);
    exp_NULL_VALUE exception;
    exp_METER_NOT_EXISTS exception;
begin

    if p_meterid IS NULL 
    or p_userid IS NULL 
    or p_meterstreetno IS NULL 
    or p_meterstreet IS NULL 
    or p_metercity IS NULL
    or p_meterstate IS NULL
    or p_metercountry IS NULL
    then 
        raise exp_NULL_VALUE;
    end if;

    select count(1) into metercount from meterboard where meter_id=p_meterid;
    
    if metercount>0
    then
        update meterboard set
        user_id=p_userid,
        meter_street_no=p_meterstreetno,
        meter_street_name=p_meterstreet,
        meter_city=p_metercity,
        meter_state=p_meterstate,
        meter_country=p_metercountry,
        units_used=p_unitsused,
        end_date=sysdate
        where meter_id=p_meterid;
        commit;
        dbms_output.put_line('meter_id Updated');      
    else
        raise exp_METER_NOT_EXISTS;
    end if;

    
exception

    when exp_NULL_VALUE
    then
        dbms_output.new_line;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('CALLED PROC WITH NULL VALUES, PLEASE SEND NON-NULL VALUES'); 
        dbms_output.put_line('---------------------------');
        
    when exp_METER_NOT_EXISTS
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


   
