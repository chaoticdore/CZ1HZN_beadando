CREATE OR REPLACE TRIGGER trg_artists_h
  AFTER INSERT OR UPDATE OR DELETE ON artists
  FOR EACH ROW
BEGIN
  IF deleting
  THEN
    INSERT INTO artists_h
      (artist_id
      ,first_name
      ,last_name
      ,birth_place
      ,birth_date
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:old.id
      ,:old.first_name
      ,:old.last_name
      ,:old.birth_place
      ,:old.birth_date
      ,sq_artists_h.nextval
      ,USER
      ,systimestamp
      ,:old.creating_user
      ,:old.creation_time
      ,'D'
      ,:old.row_version + 1);
  ELSE
    INSERT INTO artists_h
      (artist_id
      ,first_name
      ,last_name
      ,birth_place
      ,birth_date
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:new.id
      ,:new.first_name
      ,:new.last_name
      ,:new.birth_place
      ,:new.birth_date
      ,sq_artists_h.nextval
      ,:new.modifying_user
      ,:new.modification_time
      ,:new.creating_user
      ,:new.creation_time
      ,:new.dml_type
      ,:new.row_version);
  END IF;
END trg_artists_h;
/
