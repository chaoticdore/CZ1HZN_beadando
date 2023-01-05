CREATE TABLE songs (
  id number PRIMARY KEY,
  album_id NUMBER,
  band_id NUMBER NOT NULL,
  song_name VARCHAR2(250 char) NOT NULL,
  release_date DATE NOT NULL,
  song_length NUMBER NOT NULL
)
TABLESPACE USERS;
