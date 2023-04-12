set serveroutput on;

create or replace procedure
create_admin_user(
    user_name IN varchar, 
    user_pwd IN varchar,
    user_quota IN number
)
as
    userCount number;
    e_code number;
    e_msg varchar2(255);
begin

dbms_output.put_line('Inputs to the procedure create_admin_user -> (' || user_name || ',' || user_pwd || ','|| user_quota || ')');
dbms_output.put_line('Checking if user already exists...');

select count(1) into userCount from all_users where username=upper(user_name);
if userCount>0 then
    dbms_output.put_line('User: '|| user_name || ' already exists!'); 
    dbms_output.put_line('Dropping and Recreating '||'User: '|| user_name || ' with new supplied password');
    execute immediate 'drop user ' || user_name || ' cascade';
end if;

dbms_output.put_line('Creating User: '|| user_name);
execute immediate 'create user ' || user_name || ' identified by "' || user_pwd || '" default tablespace data quota ' || user_quota ||'m on data';
execute immediate 'grant CONNECT to '||user_name|| ' WITH ADMIN OPTION';
execute immediate 'grant RESOURCE to '||user_name;
execute immediate 'grant CREATE VIEW to '||user_name;
execute immediate 'grant CREATE USER to '||user_name;
execute immediate 'grant ALTER USER to '||user_name;
execute immediate 'grant CREATE SEQUENCE to '||user_name;
execute immediate 'grant DROP USER to '||user_name;
dbms_output.put_line('Granted Roles and Privileges to '|| user_name);

exception        
    when others then
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
    dbms_output.put_line('---------------------------');
    
    
    if e_code=-1940
    then
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('Error Reason: TRYING TO CREATE APP_ADMIN USER THAT IS ALREADY CONNECTED TO DB, DISCONNECT IT AND RUN THE SCRIPT AGAIN');
        dbms_output.put_line('---------------------------');
    end if;
end;
/

execute create_admin_user('app_admin', 'ProjectAdmin1234', 100);
