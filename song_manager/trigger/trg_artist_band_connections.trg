CREATE OR REPLACE TRIGGER trg_artist_band_connections
  BEFORE INSERT ON artist_band_connections
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := sq_artist_band_connections.nextval;
    END IF;
  END IF;
END trg_artist_band_connections;
/
