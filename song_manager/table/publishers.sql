CREATE TABLE publishers (
  id number PRIMARY KEY,
  publisher_name VARCHAR2(250 char) NOT NULL,
  headquarters VARCHAR2(250 char) NOT NULL,
  ceo_first_name VARCHAR2(250 char) NOT NULL,
  ceo_last_name VARCHAR2(250 char) NOT NULL,
  foundation_date DATE NOT NULL
)
TABLESPACE USERS;
