CREATE TABLE artists (
  id number PRIMARY KEY,
  first_name VARCHAR2(250 char) NOT NULL,
  last_name VARCHAR2(250 char) NOT NULL,
  birth_place VARCHAR2(250 char) NOT NULL,
  birth_date DATE NOT NULL
)
TABLESPACE USERS;
