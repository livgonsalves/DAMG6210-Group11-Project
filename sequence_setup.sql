/*

SEQUENCE SETUP

*/

set serveroutput on;

--PROC_SSMOD_SEQUENCE_SETUP
create or replace procedure
PROC_EBMS_SEQUENCE_SETUP
as
    seqCount NUMBER;
    seqName VARCHAR(255);
    e_code NUMBER;
    e_msg VARCHAR(255);
begin
 
    seqName:='SEQ_USER_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1';
    
    seqName:='SEQ_METER_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 100';
    
    seqName:='SEQ_BILLING_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 1000';
    
    seqName:='SEQ_COMPLAINT_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 10000';
    
seqName:='SEQ_ADMIN_ID';
    select count(1) into seqCount from all_sequences where sequence_name=seqName and sequence_owner='APP_ADMIN';
    
    if seqCount>0
    then
        dbms_output.put_line('Sequence : ' || seqName || ' already exists, dropping and recreating it!' );
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seqName;
    end if;
    

    dbms_output.put_line('Creating the '||'Sequence : ' || seqName);
    execute immediate 'CREATE SEQUENCE ' || seqName || ' INCREMENT BY 1 START WITH 100000';
    


exception
when others
    then dbms_output.put_line('Exception Occurred');
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
end;
/





EXECUTE   PROC_EBMS_SEQUENCE_SETUP;
