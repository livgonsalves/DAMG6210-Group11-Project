set serveroutput on;


create or replace procedure
setup_other_users
as
    userCount number;
    currentUser varchar(255);
    e_code number;
    e_msg varchar(255);
begin
    
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('Setting up other users in Electricity Bill Management System');
    dbms_output.put_line('---------------------------');
    
    --Customer
    currentUser:='CUSTOMER';
    dbms_output.put_line('Check if user: '|| currentUser ||' exists already');
    select count(1) into userCount from all_users where username=currentUser;
    if userCount>0
    then 
        dbms_output.put_line('User: '|| currentUser ||' exists already');
        dbms_output.put_line('Dropping and recreating user: '|| currentUser);
        execute immediate 'drop user '|| currentUser ||' cascade';
    end if;
    
    dbms_output.put_line('Trying to create user: '|| currentUser);
    execute immediate 'create user '|| currentUser ||' identified by "Ebms@CUST@123456789" default tablespace DATA quota 10m on DATA';
    execute immediate 'grant CONNECT to '|| currentUser;    
    dbms_output.put_line('Created user: '|| currentUser);
    dbms_output.put_line('Granted CONNECT to user: '|| currentUser);
    
    dbms_output.put_line('---------------------------');
    
    
    
        --Management Staff
    currentUser:='MGT_STAFF';
    dbms_output.put_line('Check if user: '|| currentUser ||' exists already');
    select count(1) into userCount from all_users where username=currentUser;
    if userCount>0
    then 
        dbms_output.put_line('User: '|| currentUser ||' exists already');
        dbms_output.put_line('Dropping and recreating user: '|| currentUser);
        execute immediate 'drop user '|| currentUser ||' cascade';
    end if;
    
    dbms_output.put_line('Trying to create user: '|| currentUser);
    execute immediate 'create user '|| currentUser ||' identified by "Ebms@MGTSTAFF@123456789" default tablespace DATA quota 10m on DATA';
    execute immediate 'grant CONNECT to '|| currentUser;    
    dbms_output.put_line('Created user: '|| currentUser);
    dbms_output.put_line('Granted CONNECT to user: '|| currentUser);
    
    dbms_output.put_line('---------------------------');
    
    
        --Maintainence Staff
    currentUser:='MNT_STAFF';
    dbms_output.put_line('Check if user: '|| currentUser ||' exists already');
    select count(1) into userCount from all_users where username=currentUser;
    if userCount>0
    then 
        dbms_output.put_line('User: '|| currentUser ||' exists already');
        dbms_output.put_line('Dropping and recreating user: '|| currentUser);
        execute immediate 'drop user '|| currentUser ||' cascade';
    end if;
    
    dbms_output.put_line('Trying to create user: '|| currentUser);
    execute immediate 'create user '|| currentUser ||' identified by "Ebms@MNTSTAFF@123456789" default tablespace DATA quota 10m on DATA';
    execute immediate 'grant CONNECT to '|| currentUser;    
    dbms_output.put_line('Created user: '|| currentUser);
    dbms_output.put_line('Granted CONNECT to user: '|| currentUser);
    
    dbms_output.put_line('---------------------------');
exception
    when others
    then dbms_output.put_line('Exception Occurred');
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
    
    if e_code=-1940
    then
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('Error Reason: TRYING TO CREATE USERS THAT ARE ALREADY CONNECTED TO DB, DISCONNECT THEM AND RUN THE SCRIPT AGAIN');
        dbms_output.put_line('---------------------------');
    end if;
end;
/

--Beginning procedure to create users
execute setup_other_users;
