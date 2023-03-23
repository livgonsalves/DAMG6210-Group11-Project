
--View 1 - To show the status of payment for specific meter
CREATE OR REPLACE VIEW payment_status_per_meter_view AS
SELECT
first_name  || ' ' || last_name AS name ,
users.phone_no,
users.email_id,
billing.payment_status
FROM billing
LEFT JOIN users
ON users.user_id = billing.user_id
WHERE users.user_type = upper('customer')
;



--View 2- To show the status on created case for user complaints
CREATE OR REPLACE VIEW complaint_status_view AS
SELECT 
users.user_id ,
first_name  || ' ' || last_name AS name ,
complaint_status,
complaint.complaint_desc
FROM complaint
LEFT JOIN users
ON complaint.user_id = users.user_id
WHERE users.user_type = upper('customer') 
;



--View 3 Total meter for each user
CREATE OR REPLACE VIEW total_meters_per_user_view AS
SELECT 
users.user_id ,
first_name  || ' ' || last_name AS name ,
COUNT(meterboard.meter_id) AS "Number of meters per user"
FROM meterboard 
LEFT JOIN users on meterboard.user_id = users.user_id
GROUP BY users.user_id,first_name,last_name
ORDER BY users.user_id
;



--View 4 Age of meter 
CREATE OR REPLACE VIEW total_bills_per_meter_view AS
SELECT 
meterboard.meter_id,
users.user_id ,
first_name  || ' ' || last_name AS name ,
ROUND (MONTHS_BETWEEN (meterboard.end_date, meterboard.start_date )) AS "Number of bills generated for the user"
FROM meterboard
LEFT JOIN users on meterboard.user_id = users.user_id
ORDER BY users.user_id
;
 
 
 
--View 5 see the payment type
CREATE OR REPLACE VIEW types_of_payment_view AS
SELECT 
billing.billing_id,
users.user_id ,
first_name  || ' ' || last_name AS name ,
billing.payment_type
FROM billing
JOIN users 
ON billing.user_id = users.user_id
ORDER BY user_id;


--granting view access to users 

grant select on payment_status_per_meter_view to CUSTOMER , MGT_STAFF;
grant select on complaint_status_view to CUSTOMER , MNT_STAFF;
grant select on total_meters_per_user_view to CUSTOMER , MGT_STAFF, MNT_STAFF;
grant select on total_bills_per_meter_view to CUSTOMER , MGT_STAFF;
grant select on types_of_payment_view to CUSTOMER , MGT_STAFF;






