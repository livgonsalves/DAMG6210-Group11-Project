CREATE OR REPLACE PACKAGE user_management AS

  -- Procedure for creating a new user
  PROCEDURE create_user(
    user_id IN VARCHAR2,
    first_name IN VARCHAR2,
    last_name IN VARCHAR2,

    password IN VARCHAR2,
    email IN VARCHAR2,
    phone_no IN VARCHAR2,
    street IN VARCHAR2
    city IN VARCHAR2
    state IN VARCHAR2
    country IN VARCHAR2
  );
  
  -- Procedure for updating user information
  PROCEDURE update_user(
    user_id IN VARCHAR2,
    email IN VARCHAR2,
    phone_no IN VARCHAR2,
    address IN VARCHAR2
  );
  
  -- Procedure for deleting a user
  PROCEDURE delete_user(
    user_id IN VARCHAR2
  );

 -- Procedure for inactivating a user
  PROCEDURE inactivate_user(
    user_id IN VARCHAR2
  );

 -- Procedure for checking user active status
  PROCEDURE is_user_activate(
    user_id IN VARCHAR2
  );

 -- Procedure for fetching a user
  PROCEDURE get_user_registration(
    first_name IN VARCHAR2,
    last_name IN VARCHAR2,
  );

-- Procedure for fetching a user
  PROCEDURE get_user_registration(
     email IN VARCHAR2
  );
