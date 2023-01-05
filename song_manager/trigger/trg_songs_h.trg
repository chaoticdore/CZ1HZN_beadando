CREATE OR REPLACE TRIGGER trg_songs_h
  AFTER INSERT OR UPDATE OR DELETE ON songs
  FOR EACH ROW
BEGIN
  IF deleting
  THEN
    INSERT INTO songs_h
      (song_id
      ,song_name
      ,album_id
      ,band_id
      ,release_date
      ,song_length
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:old.id
      ,:old.song_name
      ,:old.album_id
      ,:old.band_id
      ,:old.release_date
      ,:old.song_length
      ,sq_songs_h.nextval
      ,USER
      ,systimestamp
      ,:old.creating_user
      ,:old.creation_time
      ,'D'
      ,:old.row_version + 1);
  ELSE
    INSERT INTO songs_h
      (song_id
      ,song_name
      ,album_id
      ,band_id
      ,release_date
      ,song_length
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:new.id
      ,:new.song_name
      ,:new.album_id
      ,:new.band_id
      ,:new.release_date
      ,:new.song_length
      ,sq_songs_h.nextval
      ,:new.modifying_user
      ,:new.modification_time
      ,:new.creating_user
      ,:new.creation_time
      ,:new.dml_type
      ,:new.row_version);
  END IF;
END trg_songs_h;
/
