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
        dbms_output.put_line('Table: BILLING Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE BILLING';
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
        dbms_output.put_line('Table: COMPLAINT Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE COMPLAINT';
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
        dbms_output.put_line('Table: METERBOARD Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE METERBOARD';
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
        dbms_output.put_line('Table: USERS Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE USERS';
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
        dbms_output.put_line('Table: ADMIN Already exists, dropping it');
        EXECUTE IMMEDIATE 'DROP TABLE ADMIN';
    END IF;
END;
/

CREATE TABLE ADMIN
(
    ADMIN_ID NUMBER,
    FIRSTNAME VARCHAR2(30),
    LASTNAME VARCHAR2(30)
);

-- Add Primary Key constraint for admin_id in admin table
ALTER TABLE ADMIN ADD CONSTRAINT pk_cat_admin_id PRIMARY KEY ( admin_id );

-- Modify Not Null constraint for admin_id in admin table
ALTER TABLE ADMIN MODIFY (
    admin_id NUMBER
        CONSTRAINT nn_cat_admin_id NOT NULL
);

-- Modify Not Null constraint for first_name in admin table
ALTER TABLE ADMIN MODIFY (
    firstname VARCHAR(30)
        CONSTRAINT nn_cat_firstname NOT NULL
);

-- Modify Not Null constraint for last_name in admin table
ALTER TABLE ADMIN MODIFY (
    lastname VARCHAR(30)
        CONSTRAINT nn_cat_lastname NOT NULL
);

CREATE TABLE USERS
(
    USER_ID NUMBER,
    ADMIN_ID NUMBER,
    FIRST_NAME VARCHAR2(30),
    LAST_NAME VARCHAR2(30),
    DOB DATE,
    PHONE_NO NUMBER(20),
    EMAIL_ID VARCHAR2(50),
    STREET_NO NUMBER,
    STREET_NAME VARCHAR2(100),
    CITY VARCHAR2(30),
    STATE_NAME CHAR(2),
    COUNTRY CHAR(2),
    USER_TYPE VARCHAR2(30)

);

-- Add Primary Key constraint for user_id in users table
ALTER TABLE USERS ADD CONSTRAINT pk_cat_user_id PRIMARY KEY ( user_id );

-- Modify Not Null constraint for user_id in users table
ALTER TABLE USERS MODIFY (
    user_id NUMBER
        CONSTRAINT nn_cat_user_id NOT NULL
);
-- Create Foreign Key constraint for admin_id in users table
ALTER TABLE USERS
    ADD CONSTRAINT fk_adm_admin_id FOREIGN KEY ( admin_id )
        REFERENCES admin ( admin_id );
        


-- Modify Not Null constraint for first_name in users table
ALTER TABLE USERS MODIFY (
    first_name VARCHAR(30)
        CONSTRAINT nn_cat_first_name NOT NULL
); 

-- Modify Not Null constraint for last_name in users table
ALTER TABLE USERS MODIFY (
    last_name VARCHAR(30)
        CONSTRAINT nn_cat_last_name NOT NULL
); 

-- Modify Not Null constraint for DOB in users table
ALTER TABLE USERS MODIFY (
    dob DATE
        CONSTRAINT nn_cat_dob NOT NULL
); 

-- Modify Not Null constraint for phone_no in users table
ALTER TABLE USERS MODIFY (
    phone_no NUMBER
        CONSTRAINT nn_cat_phone_no NOT NULL
); 

-- Modify Not Null and Unique constraint for email_id in users table
ALTER TABLE USERS MODIFY (
    email_id VARCHAR(50)
        CONSTRAINT nn_cat_email_id NOT NULL
); 

ALTER TABLE USERS MODIFY (
    email_id VARCHAR(50)
        CONSTRAINT un_cat_email_id UNIQUE
); 
-- Modify Not Null constraint for street_no in users table
ALTER TABLE USERS MODIFY (
    street_no NUMBER
        CONSTRAINT nn_cat_street_no NOT NULL
); 

-- Modify Not Null constraint for street_name in users table
ALTER TABLE USERS MODIFY (
    street_name VARCHAR(100)
        CONSTRAINT nn_cat_street_name NOT NULL
); 

-- Modify Not Null constraint for city in users table
ALTER TABLE USERS MODIFY (
    city VARCHAR(30)
        CONSTRAINT nn_cat_city NOT NULL
); 

-- Modify Not Null constraint for state_name in users table
ALTER TABLE USERS MODIFY (
    state_name CHAR(2)
        CONSTRAINT nn_cat_state_name NOT NULL
); 

-- Modify Not Null constraint for country in users table
ALTER TABLE USERS MODIFY (
    country CHAR(2)
        CONSTRAINT nn_cat_country NOT NULL
);


CREATE TABLE METERBOARD
(
    METER_ID NUMBER,
    USER_ID NUMBER,
    METER_STREET_NO NUMBER,
    METER_STREET_NAME VARCHAR2(100),
    METER_CITY VARCHAR2(30),
    METER_STATE CHAR(2),
    METER_COUNTRY CHAR(2),
    UNITS_USED NUMBER,
    START_DATE DATE,
    END_DATE DATE
);

-- Add Primary Key constraint for meter_id in meterboard table
ALTER TABLE meterboard ADD CONSTRAINT pk_meter_id PRIMARY KEY ( meter_id );

-- Modify Not Null constraint for meter_id in meterboard table
ALTER TABLE meterboard MODIFY (
    meter_id NUMBER
        CONSTRAINT nn_meter_id NOT NULL
);

-- Add Foreign Key constraint for user_id in meterboard table
ALTER TABLE meterboard
    ADD CONSTRAINT fk_user_id FOREIGN KEY ( user_id )
        REFERENCES users ( user_id );
        
-- Create Not Null constraint for meter_street_no in meterboard table
ALTER TABLE meterboard MODIFY (
    meter_street_no NUMBER
        CONSTRAINT nn_cat_meter_street_no NOT NULL 
); 

ALTER TABLE meterboard MODIFY (
    meter_street_no NUMBER
        CONSTRAINT un_cat_meter_street_no UNIQUE
); 

-- Modify Not Null constraint for meter_street_name in meterboard table
ALTER TABLE meterboard MODIFY (
    meter_street_name VARCHAR(100)
        CONSTRAINT nn_cat_meter_street_name NOT NULL
); 

-- Modify Not Null constraint for meter_city in meterboard table
ALTER TABLE meterboard MODIFY (
    meter_city VARCHAR(30)
        CONSTRAINT nn_cat_meter_city NOT NULL
); 

-- Modify Not Null constraint for meter_state in meterboard table
ALTER TABLE meterboard MODIFY (
    meter_state CHAR(2)
        CONSTRAINT nn_cat_meter_state NOT NULL
); 

-- Modify Not Null constraint for meter_country in meterboard table
ALTER TABLE meterboard MODIFY (
    meter_country CHAR(2)
        CONSTRAINT nn_cat_meter_country NOT NULL
);     

-- Modify Not Null constraint for units_used in meterboard table
ALTER TABLE meterboard MODIFY (
    units_used float
        CONSTRAINT nn_cat_units_used NOT NULL
);  

-- Modify Not Null constraint for start_date in meterboard table
ALTER TABLE meterboard MODIFY (
   start_date date
        CONSTRAINT nn_cat_start_date NOT NULL
);  

   
-- Modify Not Null constraint for end_date in meterboard table
ALTER TABLE meterboard MODIFY (
   end_date date
        CONSTRAINT nn_cat_end_date NOT NULL
);  

CREATE TABLE COMPLAINT
(
    COMPLAINT_ID NUMBER,
    USER_ID NUMBER,
    METER_ID NUMBER,
    COMPLAINT_DESC VARCHAR2(100),
    COMPLAINT_STATUS VARCHAR2(30),
    UPDATED_BY VARCHAR2(30),
    UPDATED_AT VARCHAR2(30)
);

-- Add Primary Key constraint for complaint_id in complaint table
ALTER TABLE complaint ADD CONSTRAINT pk_complaint_id PRIMARY KEY ( complaint_id );

-- Modify Not Null constraint for complaint_id in complaint table
ALTER TABLE complaint MODIFY (
    complaint_id NUMBER(20)
        CONSTRAINT nn_complaint_id NOT NULL
);

-- Add Foreign Key constraint for user_id in complaint table
ALTER TABLE complaint
    ADD CONSTRAINT fk_comp_user_id FOREIGN KEY ( user_id )
        REFERENCES users ( user_id );
        
-- Add Foreign Key constraint for meter_id in complaint table
ALTER TABLE complaint
    ADD CONSTRAINT fk_comp_meter_id FOREIGN KEY ( meter_id )
        REFERENCES meterboard ( meter_id );

-- Modify Not Null constraint for complaint_desc in complaint table
ALTER TABLE complaint MODIFY (
    complaint_desc varchar(100)
        CONSTRAINT nn_complaint_desc NOT NULL
);

-- Modify Not Null constraint for complaint_status in complaint table
ALTER TABLE complaint MODIFY (
    complaint_status varchar(30)
        CONSTRAINT nn_complaint_status NOT NULL
);

CREATE TABLE BILLING
(
    BILLING_ID NUMBER,
    USER_ID NUMBER,
    METER_ID NUMBER,
    Billing_START_DATE DATE,
    Billing_END_DATE DATE,
    Billing_UNITS_USED FLOAT,
    PAYMENT_TYPE VARCHAR2(30),   
    PAYMENT_STATUS VARCHAR2(30),   
    SERVICE_CHARGE FLOAT,
    DIST_CHARGE FLOAT,
    DUE_DATE DATE,
    BILLING_AMOUNT FLOAT

);

-- Create Primary Key constraint for billing_id in billing table
ALTER TABLE billing ADD CONSTRAINT pk_billing_id PRIMARY KEY ( billing_id );

-- Modify Not Null constraint for billing_id in billing table
ALTER TABLE billing MODIFY (
    billing_id NUMBER(20)
        CONSTRAINT nn_billing_id NOT NULL
);

-- Add Foreign Key constraint for user_id in billing table
ALTER TABLE billing
    ADD CONSTRAINT fk_billing_user_id FOREIGN KEY ( user_id )
        REFERENCES users ( user_id );
        
-- Add Foreign Key constraint for meter_id in billing table
ALTER TABLE billing
    ADD CONSTRAINT fk_billing_meter_id FOREIGN KEY ( meter_id )
        REFERENCES meterboard ( meter_id );

-- Modify Not Null constraint for billing_start_date in billing table
ALTER TABLE billing MODIFY (
    billing_start_date date
        CONSTRAINT nn_billing_start_date NOT NULL
);
-- Modify Not Null constraint for billing_end_date in billing table
ALTER TABLE billing MODIFY (
    billing_end_date date
        CONSTRAINT nn_billing_end_date NOT NULL
);

-- Modify Not Null constraint for due_date in billing table
ALTER TABLE billing MODIFY (
    due_date date
        CONSTRAINT nn_due_date NOT NULL
);

-- Modify Not Null constraint for billing_units_used in billing table
ALTER TABLE billing MODIFY (
    billing_units_used float
        CONSTRAINT nn_billing_units_used NOT NULL
);

-- Modify Not Null constraint for service_charge in billing table
ALTER TABLE billing MODIFY (
    service_charge float
        CONSTRAINT nn_service_charge NOT NULL
);

-- Modify Not Null constraint for dist_charge in billing table
ALTER TABLE billing MODIFY (
    dist_charge float
        CONSTRAINT nn_dist_charge NOT NULL
);

-- Modify Not Null constraint for billing_amount in billing table
ALTER TABLE billing MODIFY (
    billing_amount float
        CONSTRAINT nn_billing_amount NOT NULL
);

/*
-- Modify Not Null constraint for payment_type in billing table
ALTER TABLE billing MODIFY (
    payment_type varchar2(30)
        CONSTRAINT nn_payment_type NOT NULL
);
*/
-- Modify Not Null constraint for payment_status in billing table
ALTER TABLE billing MODIFY (
    payment_status varchar2(30)
        CONSTRAINT nn_payment_status NOT NULL
);



commit;
