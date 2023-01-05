CREATE OR REPLACE TRIGGER trg_albums_h
  AFTER INSERT OR UPDATE OR DELETE ON albums
  FOR EACH ROW
BEGIN
  IF deleting
  THEN
    INSERT INTO albums_h
      (album_id
      ,album_name
      ,band_id
      ,release_date
      ,publisher_id
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:old.id
      ,:old.album_name
      ,:old.band_id
      ,:old.release_date
      ,:old.publisher_id
      ,sq_songs_h.nextval
      ,USER
      ,systimestamp
      ,:old.creating_user
      ,:old.creation_time
      ,'D'
      ,:old.row_version + 1);
  ELSE
    INSERT INTO albums_h
      (album_id
      ,album_name
      ,band_id
      ,release_date
      ,publisher_id
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:new.id
      ,:new.album_name
      ,:new.band_id
      ,:new.release_date
      ,:new.publisher_id
      ,sq_songs_h.nextval
      ,:new.modifying_user
      ,:new.modification_time
      ,:new.creating_user
      ,:new.creation_time
      ,:new.dml_type
      ,:new.row_version);
  END IF;
END trg_albums_h;
/
