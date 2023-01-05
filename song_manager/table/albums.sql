CREATE TABLE albums (
  id number PRIMARY KEY,
  band_id NUMBER NOT NULL,
  album_name VARCHAR2(250 char) NOT NULL,
  release_date DATE NOT NULL,
  publisher_id NUMBER NOT NULL
)
TABLESPACE USERS;
