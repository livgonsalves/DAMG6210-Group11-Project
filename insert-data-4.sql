PURGE RECYCLEBIN;

SET SERVEROUTPUT ON;

DECLARE
    is_true NUMBER;
BEGIN
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('CHECKING IF Electricity Bill Management System TABLES ALREADY EXISTS');
    dbms_output.put_line('---------------------------');
    
     --Billing
     SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'BILLING';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: BILLING Already exists, delete rows');
        Delete from BILLING;
    END IF;
    
     --Complaint
     SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'COMPLAINT';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: COMPLAINT Already exists, delete rows');
        Delete from COMPLAINT;
    END IF;
    
    --Meterboard
     SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'METERBOARD';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: METERBOARD Already exists, delete rows');
        Delete from METERBOARD;
    END IF;
    
    --Users
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'USERS';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: USERS Already exists, delete rows');
        Delete from USERS;
    END IF;

    --Admin
    SELECT
        COUNT(*)
    INTO is_true
    FROM
        user_tables
    WHERE
        table_name = 'ADMIN';

    IF is_true > 0 THEN
        dbms_output.put_line('Table: ADMIN Already exists, delete rows');
        Delete from ADMIN;
    END IF;
END;
/


INSERT INTO ADMIN VALUES (SEQ_ADMIN_ID.nextval, 'John', 'Doe');


INSERT INTO USERS VALUES(SEQ_USER_ID.nextval,SEQ_ADMIN_ID.currval, 'John', 'Doe', TO_DATE('01-JAN-1980', 'DD-MON-YYYY'), 1234567890, 'livg@example.com', 123, 'Main St', 'Anytown', 'CA', 'US', 'CUSTOMER');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 123, 'Main St', 'Anytown', 'NY',  'US', 120, TO_DATE('01-JAN-2020', 'DD-MON-YYYY'), TO_DATE('28-FEB-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 120, 'CREDIT CARD', 'PAID', 10.00, 5.00, TO_DATE('15-FEB-2023', 'DD-MON-YYYY'), 100.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter reading not accurate', 'PENDING');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter not working', 'IN PROGRESS');




INSERT INTO USERS VALUES(SEQ_USER_ID.nextval,SEQ_ADMIN_ID.currval, 'Jane', 'Doe', TO_DATE('02-FEB-1985', 'DD-MON-YYYY'), 2345678901, 'deepthir@example.com', 456, 'Broadway', 'Sometown', 'NY','US', 'CUSTOMER');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 456, 'Oak Ave', 'Anycity', 'CA', 'US', 85, TO_DATE('10-JAN-2020', 'DD-MON-YYYY'), TO_DATE('30-MAR-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 789, 'Main St', 'Anycity', 'FL',  'US', 150, TO_DATE('28-JAN-2021', 'DD-MON-YYYY'), TO_DATE('28-OCT-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 120, 'CREDIT CARD', 'PAID', 10.00, 5.00, TO_DATE('15-FEB-2023', 'DD-MON-YYYY'), 100.00);
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 150, 'DEBIT CARD', 'PAID', 12.00, 6.00, TO_DATE('15-MAR-2023', 'DD-MON-YYYY'), 120.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter reading not accurate', 'PENDING');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter not working', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'High billing amount', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter damaged', 'PENDING');




INSERT INTO USERS VALUES(SEQ_USER_ID.nextval,SEQ_ADMIN_ID.currval, 'Bob', 'Smith', TO_DATE('03-MAR-1970', 'DD-MON-YYYY'), 3456789012, 'bobsmith@example.com', 789, 'Oak St', 'Anycity', 'TX', 'US', 'MANAGEMENT STAFF');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 234, 'Elm St', 'Anytown', 'NY', 'US', 100, TO_DATE('02-FEB-2021', 'DD-MON-YYYY'), TO_DATE('30-OCT-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 200, 'BANK TRANSFER', 'PENDING', 15.00, 7.00, TO_DATE('15-APR-2023', 'DD-MON-YYYY'), 150.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'New connection request', 'PENDING');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter reading not take', 'IN PROGRESS');



INSERT INTO USERS VALUES(SEQ_USER_ID.nextval,SEQ_ADMIN_ID.currval ,'Mary', 'Johnson', TO_DATE('04-APR-1990', 'DD-MON-YYYY'), 4567890123, 'maryjohnson@example.com', 12, 'Pine St', 'Smalltown', 'FL', 'US', 'CUSTOMER');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 243, 'Elm St', 'Anytown', 'NY', 'US', 100, TO_DATE('02-FEB-2021', 'DD-MON-YYYY'), TO_DATE('30-OCT-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 100, 'MOBILE PAYMENTS', 'PENDING', 8.00, 4.00, TO_DATE('15-MAY-2023', 'DD-MON-YYYY'), 80.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Billing dispute', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval , 'Meter installed in wrong location', 'PENDING');


INSERT INTO USERS VALUES(SEQ_USER_ID.nextval, SEQ_ADMIN_ID.currval, 'Mike', 'Davis', TO_DATE('05-MAY-1980', 'DD-MON-YYYY'), 5678901234, 'mikedavis@example.com', 345, 'Maple Ave', 'Othertown', 'OH', 'US', 'MAINTENANCE STAFF');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 567, 'Maple Ave', 'Anycity', 'CA', 'US', 200, TO_DATE('10-FEB-2021', 'DD-MON-YYYY'), TO_DATE('28-NOV-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 175, 'CREDIT CARD', 'PAID', 11.00, 5.50, TO_DATE('15-JUN-2023', 'DD-MON-YYYY'), 130.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Electricity supply not available', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter reading not taken', 'RESOLVED');



INSERT INTO USERS VALUES(SEQ_USER_ID.nextval,SEQ_ADMIN_ID.currval, 'Samantha', 'Lee', TO_DATE('06-JUN-1995', 'DD-MON-YYYY'), 6789012345, 'samanthalee@example.com', 678, 'Cedar St', 'Bigcity', 'IL', 'US', 'CUSTOMER');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 890, 'Main St', 'Anycity', 'FL',  'US', 175, TO_DATE('01-MAR-2021', 'DD-MON-YYYY'), TO_DATE('30-NOV-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 321, 'Cedar St', 'Anytown', 'NY', 'US', 90, TO_DATE('15-MAR-2022', 'DD-MON-YYYY'), TO_DATE('10-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 80, 'DEBIT CARD', 'PAID', 5.00, 2.50, TO_DATE('15-JUL-2023', 'DD-MON-YYYY'), 60.00);
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 300, 'BANK TRANSFER', 'PENDING', 20.00, 10.00, TO_DATE('15-AUG-2023', 'DD-MON-YYYY'), 250.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Billing not received', 'PENDING');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter readings not updated', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter not sealed', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Billing dispute', 'PENDING');




INSERT INTO USERS VALUES(SEQ_USER_ID.nextval,SEQ_ADMIN_ID.currval, 'David', 'Garcia', TO_DATE('07-JUL-1982', 'DD-MON-YYYY'), 7890123456, 'davidgarcia@example.com', 901, 'Elm St', 'Somewhere', 'CA', 'US', 'CUSTOMER');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 654, 'Pine Ave', 'Anycity', 'CA',  'US', 150, TO_DATE('17-APR-2022', 'DD-MON-YYYY'), TO_DATE('15-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 150, 'MOBILE PAYMENTS', 'PAID', 12.00, 6.00, TO_DATE('15-SEP-2023', 'DD-MON-YYYY'), 120.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter not responding', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Wrong billing amount', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Billing dispute', 'PENDING');


INSERT INTO USERS VALUES(SEQ_USER_ID.nextval,SEQ_ADMIN_ID.currval, 'Emily', 'Wilson', TO_DATE('08-AUG-1978', 'DD-MON-YYYY'), 8901234567, 'emilywilson@example.com', 234, 'Spruce St', 'Anothercity', 'GA', 'US', 'MANAGEMENT STAFF');
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 987, 'Main St', 'Anycity', 'FL',  'US', 100, TO_DATE('20-MAY-2022', 'DD-MON-YYYY'), TO_DATE('28-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (SEQ_METER_ID.nextval, SEQ_USER_ID.currval, 294, 'Elm St', 'Anytown', 'NY', 'US', 120, TO_DATE('10-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 200, 'DEBIT CARD', 'PAID', 12.00, 6.00, TO_DATE('15-SEP-2023', 'DD-MON-YYYY'), 320.00);
INSERT INTO BILLING VALUES (SEQ_BILLING_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 220, 'DEBIT CARD', 'PAID', 12.00, 6.00, TO_DATE('15-SEP-2023', 'DD-MON-YYYY'), 400.00);
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Meter not calibrated', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Electricity supply cut off', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Incorrect meter reading taken', 'PENDING');
INSERT INTO COMPLAINT VALUES (SEQ_COMPLAINT_ID.nextval, SEQ_USER_ID.currval, SEQ_METER_ID.currval, 'Wrong meter installed', 'IN PROGRESS');







