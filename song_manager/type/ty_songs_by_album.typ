CREATE OR REPLACE TYPE ty_songs_by_album AS OBJECT
(
  band_name      VARCHAR2(250),
  album_name     VARCHAR2(250),
  songs_in_album ty_songs_in_album_l,

  CONSTRUCTOR FUNCTION ty_songs_by_album RETURN SELF AS RESULT
)
/
CREATE OR REPLACE TYPE BODY ty_songs_by_album IS

  CONSTRUCTOR FUNCTION ty_songs_by_album RETURN SELF AS RESULT IS
  BEGIN
    RETURN;
  END;

END;
/
