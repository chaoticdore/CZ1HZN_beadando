CREATE OR REPLACE TRIGGER trg_genre_album_connections
  BEFORE INSERT ON genre_album_connections
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := sq_genre_album_connections.nextval;
    END IF;
  END IF;
END trg_genre_album_connections;
/
