--iew grants grants

grant select on payment_status_per_meter_view to CUSTOMER , MGT_STAFF;
grant select on complaint_status_view to CUSTOMER , MNT_STAFF;
grant select on total_meters_per_user_view to CUSTOMER , MGT_STAFF, MNT_STAFF;
grant select on total_bills_per_meter_view to CUSTOMER , MGT_STAFF;
grant select on types_of_payment_view to CUSTOMER , MGT_STAFF;

--MAINTAINCE STAFF
grant execute on insert_complaint_pkg to MNT_STAFF;




--MANAGEMENT STAFF

grant execute on meterboard_pkg to MGT_STAFF;
grant execute on users_pkg to MGT_STAFF;
grant execute on billing_pkg to MGT_STAFF;





--CUSTOMER

grant execute on users_pkg to CUSTOMER;
grant execute on insert_complaint_pkg to CUSTOMER;