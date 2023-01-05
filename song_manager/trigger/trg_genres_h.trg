CREATE OR REPLACE TRIGGER trg_genres_h
  AFTER INSERT OR UPDATE OR DELETE ON genres
  FOR EACH ROW
BEGIN
  IF deleting
  THEN
    INSERT INTO genres_h
      (genre_id
      ,genre_name
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:old.id
      ,:old.genre_name
      ,sq_songs_h.nextval
      ,USER
      ,systimestamp
      ,:old.creating_user
      ,:old.creation_time
      ,'D'
      ,:old.row_version + 1);
  ELSE
    INSERT INTO genres_h
      (genre_id
      ,genre_name
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:new.id
      ,:new.genre_name
      ,sq_songs_h.nextval
      ,:new.modifying_user
      ,:new.modification_time
      ,:new.creating_user
      ,:new.creation_time
      ,:new.dml_type
      ,:new.row_version);
  END IF;
END trg_genres_h;
/
