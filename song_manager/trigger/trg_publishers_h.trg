CREATE OR REPLACE TRIGGER trg_publishers_h
  AFTER INSERT OR UPDATE OR DELETE ON publishers
  FOR EACH ROW
BEGIN
  IF deleting
  THEN
    INSERT INTO publishers_h
      (publisher_id
      ,publisher_name
      ,headquarters
      ,ceo_first_name
      ,ceo_last_name
      ,foundation_date
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:old.id
      ,:old.publisher_name
      ,:old.headquarters
      ,:old.ceo_first_name
      ,:old.ceo_last_name
      ,:old.foundation_date
      ,sq_songs_h.nextval
      ,USER
      ,systimestamp
      ,:old.creating_user
      ,:old.creation_time
      ,'D'
      ,:old.row_version + 1);
  ELSE
    INSERT INTO publishers_h
      (publisher_id
      ,publisher_name
      ,headquarters
      ,ceo_first_name
      ,ceo_last_name
      ,foundation_date
      ,id
      ,modifying_user
      ,modification_time
      ,creating_user
      ,creation_time
      ,dml_type
      ,row_version)
    VALUES
      (:new.id
      ,:new.publisher_name
      ,:new.headquarters
      ,:new.ceo_first_name
      ,:new.ceo_last_name
      ,:new.foundation_date
      ,sq_songs_h.nextval
      ,:new.modifying_user
      ,:new.modification_time
      ,:new.creating_user
      ,:new.creation_time
      ,:new.dml_type
      ,:new.row_version);
  END IF;
END trg_publishers_h;
/
