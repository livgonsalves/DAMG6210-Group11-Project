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


INSERT INTO ADMIN VALUES (1, 'John', 'Doe');
INSERT INTO ADMIN VALUES (2, 'Jane', 'Smith');
INSERT INTO ADMIN VALUES (3, 'Bob', 'Johnson');
INSERT INTO ADMIN VALUES (4, 'Emily', 'Davis');
INSERT INTO ADMIN VALUES (5, 'David', 'Lee');
INSERT INTO ADMIN VALUES (6, 'Sarah', 'Jones');
INSERT INTO ADMIN VALUES (7, 'Michael', 'Brown');
INSERT INTO ADMIN VALUES (8, 'Rachel', 'Green');
INSERT INTO ADMIN VALUES (9, 'Adam', 'Scott');
INSERT INTO ADMIN VALUES (10, 'Laura', 'Smith');
INSERT INTO ADMIN VALUES (11, 'Brian', 'Johnson');
INSERT INTO ADMIN VALUES (12, 'Samantha', 'Williams');
INSERT INTO ADMIN VALUES (13, 'Eric', 'Anderson');
INSERT INTO ADMIN VALUES (14, 'Jessica', 'Taylor');
INSERT INTO ADMIN VALUES (15, 'Daniel', 'Clark');
INSERT INTO ADMIN VALUES (16, 'Katie', 'Wilson');
INSERT INTO ADMIN VALUES (17, 'Timothy', 'Garcia');
INSERT INTO ADMIN VALUES (18, 'Caroline', 'Lopez');
INSERT INTO ADMIN VALUES (19, 'Richard', 'Perez');
INSERT INTO ADMIN VALUES (20, 'Ashley', 'Martin');

INSERT INTO USERS VALUES(1,4, 'John', 'Doe', TO_DATE('01-JAN-1980', 'DD-MON-YYYY'), 1234567890, 'johndoe@example.com', 123, 'Main St', 'Anytown', 'CA', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(2,1, 'Jane', 'Doe', TO_DATE('02-FEB-1985', 'DD-MON-YYYY'), 2345678901, 'janedoe@example.com', 456, 'Broadway', 'Sometown', 'NY','US', 'CUSTOMER');
INSERT INTO USERS VALUES(3,1, 'Bob', 'Smith', TO_DATE('03-MAR-1970', 'DD-MON-YYYY'), 3456789012, 'bobsmith@example.com', 789, 'Oak St', 'Anycity', 'TX', 'US', 'MANAGEMENT STAFF');
INSERT INTO USERS VALUES(4,2, 'Mary', 'Johnson', TO_DATE('04-APR-1990', 'DD-MON-YYYY'), 4567890123, 'maryjohnson@example.com', 12, 'Pine St', 'Smalltown', 'FL', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(5,6, 'Mike', 'Davis', TO_DATE('05-MAY-1980', 'DD-MON-YYYY'), 5678901234, 'mikedavis@example.com', 345, 'Maple Ave', 'Othertown', 'OH', 'US', 'MAINTENANCE STAFF');
INSERT INTO USERS VALUES(6,4, 'Samantha', 'Lee', TO_DATE('06-JUN-1995', 'DD-MON-YYYY'), 6789012345, 'samanthalee@example.com', 678, 'Cedar St', 'Bigcity', 'IL', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(7,3, 'David', 'Garcia', TO_DATE('07-JUL-1982', 'DD-MON-YYYY'), 7890123456, 'davidgarcia@example.com', 901, 'Elm St', 'Somewhere', 'CA', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(8,2, 'Emily', 'Wilson', TO_DATE('08-AUG-1978', 'DD-MON-YYYY'), 8901234567, 'emilywilson@example.com', 234, 'Spruce St', 'Anothercity', 'GA', 'US', 'MANAGEMENT STAFF');
INSERT INTO USERS VALUES(9,8, 'Peter', 'Brown', TO_DATE('09-SEP-1965', 'DD-MON-YYYY'), 9012345678, 'peterbrown@example.com', 567, 'Cherry St', 'Hometown', 'NJ', 'US', 'MAINTENANCE STAFF');
INSERT INTO USERS VALUES(10,9, 'Amy', 'Robinson', TO_DATE('10-OCT-1988', 'DD-MON-YYYY'), 1234567890, 'amyrobinson@example.com', 890, 'Oakwood Ave', 'Thisplace', 'MA', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(11,7, 'Jane', 'Doe', TO_DATE('15-FEB-1982', 'DD-MON-YYYY'), 2345678901, 'janedoe@example.com', 456, 'Broadway', 'Anycity', 'NY', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(12,1, 'Bob', 'Smith', TO_DATE('10-MAR-1975', 'DD-MON-YYYY'), 3456789012, 'bobsmith@example.com', 789, 'Oak St', 'Anysville', 'IL', 'US', 'MANAGEMENT STAFF');
INSERT INTO USERS VALUES(14,2, 'Alice', 'Johnson', TO_DATE('20-APR-1988', 'DD-MON-YYYY'), 4567890123, 'alicejohnson@example.com', 111, 'Main St', 'Anytown', 'CA', 'US', 'MAINTENANCE STAFF');
INSERT INTO USERS VALUES(15,5, 'Tom', 'Williams', TO_DATE('25-MAY-1985', 'DD-MON-YYYY'), 5678901234, 'tomwilliams@example.com', 222, 'Maple St', 'Anycity', 'NY', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(16,10, 'Sara', 'Garcia', TO_DATE('30-JUN-1990', 'DD-MON-YYYY'), 6789012345, 'saragarcia@example.com', 333, 'Oak St', 'Anysville', 'IL', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(17,1, 'Mike', 'Brown', TO_DATE('05-JUL-1982', 'DD-MON-YYYY'), 7890123456, 'mikebrown@example.com', 444, 'Main St', 'Anytown', 'CA','US', 'MANAGEMENT STAFF');
INSERT INTO USERS VALUES(18,1, 'Emily', 'Wilson', TO_DATE('15-AUG-1995', 'DD-MON-YYYY'), 8901234567, 'emilywilson@example.com', 555, 'Broadway', 'Anycity', 'NY', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(19,3, 'David', 'Lee', TO_DATE('20-SEP-1983', 'DD-MON-YYYY'), 9012345678, 'davidlee@example.com', 666, 'Maple St', 'Anysville', 'IL', 'US', 'CUSTOMER');
INSERT INTO USERS VALUES(20,3,'Rachel', 'Lopez', TO_DATE('10-OCT-1991', 'DD-MON-YYYY'), 1234567890, 'rachellopez@example.com', 777, 'Oak St', 'Anytown', 'CA', 'US', 'MAINTENANCE STAFF');
INSERT INTO USERS VALUES(21,3,'Steven', 'Davis', TO_DATE('05-NOV-1977', 'DD-MON-YYYY'), 2345678901, 'stevendavis@example.com', 888, 'Main St', 'Anycity', 'NY', 'US', 'CUSTOMER');


INSERT INTO METERBOARD VALUES (1, 2, 123, 'Main St', 'Anytown', 'NY',  'US', 120, TO_DATE('01-JAN-2020', 'DD-MON-YYYY'), TO_DATE('28-FEB-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (2, 2, 456, 'Oak Ave', 'Anycity', 'CA', 'US', 85, TO_DATE('10-JAN-2020', 'DD-MON-YYYY'), TO_DATE('30-MAR-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (3, 2, 789, 'Main St', 'Anycity', 'FL',  'US', 150, TO_DATE('28-JAN-2021', 'DD-MON-YYYY'), TO_DATE('28-OCT-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (4, 3, 234, 'Elm St', 'Anytown', 'NY', 'US', 100, TO_DATE('02-FEB-2021', 'DD-MON-YYYY'), TO_DATE('30-OCT-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (5, 3, 567, 'Maple Ave', 'Anycity', 'CA', 'US', 200, TO_DATE('10-FEB-2021', 'DD-MON-YYYY'), TO_DATE('28-NOV-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (6, 1, 890, 'Main St', 'Anycity', 'FL',  'US', 175, TO_DATE('01-MAR-2021', 'DD-MON-YYYY'), TO_DATE('30-NOV-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (7, 5, 123, 'Cedar St', 'Anytown', 'NY', 'US', 90, TO_DATE('15-MAR-2022', 'DD-MON-YYYY'), TO_DATE('10-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (8, 8, 456, 'Pine Ave', 'Anycity', 'CA',  'US', 150, TO_DATE('17-APR-2022', 'DD-MON-YYYY'), TO_DATE('15-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (9, 9, 789, 'Main St', 'Anycity', 'FL',  'US', 100, TO_DATE('20-MAY-2022', 'DD-MON-YYYY'), TO_DATE('28-DEC-2023', 'DD-MON-YYYY'));
INSERT INTO METERBOARD VALUES (10,10, 234, 'Elm St', 'Anytown', 'NY', 'US', 120, TO_DATE('10-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-DEC-2023', 'DD-MON-YYYY'));


INSERT INTO BILLING VALUES (1, 3, 1, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 120, 'CREDIT CARD', 'PAID', 10.00, 5.00, TO_DATE('15-FEB-2023', 'DD-MON-YYYY'), 100.00);
INSERT INTO BILLING VALUES (2, 2, 2, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 150, 'DEBIT CARD', 'PAID', 12.00, 6.00, TO_DATE('15-MAR-2023', 'DD-MON-YYYY'), 120.00);
INSERT INTO BILLING VALUES (3, 2, 3, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 200, 'BANK TRANSFER', 'PENDING', 15.00, 7.00, TO_DATE('15-APR-2023', 'DD-MON-YYYY'), 150.00);
INSERT INTO BILLING VALUES (4, 4, 4, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 100, 'MOBILE PAYMENTS', 'ISSUED', 8.00, 4.00, TO_DATE('15-MAY-2023', 'DD-MON-YYYY'), 80.00);
INSERT INTO BILLING VALUES (5, 2, 5, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 175, 'CREDIT CARD', 'PAID', 11.00, 5.50, TO_DATE('15-JUN-2023', 'DD-MON-YYYY'), 130.00);
INSERT INTO BILLING VALUES (6, 3, 6, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 80, 'DEBIT CARD', 'PAID', 5.00, 2.50, TO_DATE('15-JUL-2023', 'DD-MON-YYYY'), 60.00);
INSERT INTO BILLING VALUES (7, 4, 7, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 300, 'BANK TRANSFER', 'SENT', 20.00, 10.00, TO_DATE('15-AUG-2023', 'DD-MON-YYYY'), 250.00);
INSERT INTO BILLING VALUES (8, 4, 8, TO_DATE('01-JAN-2023', 'DD-MON-YYYY'), TO_DATE('31-JAN-2023', 'DD-MON-YYYY'), 150, 'MOBILE PAYMENTS', 'PAID', 12.00, 6.00, TO_DATE('15-SEP-2023', 'DD-MON-YYYY'), 120.00);


INSERT INTO COMPLAINT VALUES (1, 2, 1, 'Meter reading not accurate', 'PENDING');
INSERT INTO COMPLAINT VALUES (2, 2, 1, 'Meter not working', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (3, 2, 1, 'High billing amount', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (4, 2, 2, 'Meter damaged', 'PENDING');
INSERT INTO COMPLAINT VALUES (5, 2, 2, 'New connection request', 'PENDING');
INSERT INTO COMPLAINT VALUES (6, 2, 3, 'Low water pressure', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (7, 1, 6, 'Water contamination', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (8, 1, 6, 'Meter installed in wrong location', 'PENDING');
INSERT INTO COMPLAINT VALUES (9, 1, 6, 'Water supply not available', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (10, 1, 6, 'Meter reading not taken', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (11, 1, 6, 'Billing not received', 'PENDING');
INSERT INTO COMPLAINT VALUES (12, 2, 3, 'Meter readings not updated', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (13, 3, 3, 'Meter not sealed', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (14, 3, 4, 'Water leakage', 'PENDING');
INSERT INTO COMPLAINT VALUES (15, 5, 7, 'Meter not responding', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (16, 3, 3, 'Wrong billing amount', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (17, 3, 4, 'Billing dispute', 'PENDING');
INSERT INTO COMPLAINT VALUES (18, 8, 8, 'Meter not calibrated', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (19, 5, 7, 'Water supply cut off', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (20, 8, 8, 'Incorrect meter reading taken', 'PENDING');
INSERT INTO COMPLAINT VALUES (21, 8, 8, 'Wrong meter installed', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (22, 8, 8, 'Water meter not installed', 'RESOLVED');
INSERT INTO COMPLAINT VALUES (23, 8, 8, 'Meter reading taken after due date', 'PENDING');
INSERT INTO COMPLAINT VALUES (24, 1, 6, 'Excessive billing', 'IN PROGRESS');
INSERT INTO COMPLAINT VALUES (25, 5, 7, 'Incorrect service charge', 'RESOLVED');