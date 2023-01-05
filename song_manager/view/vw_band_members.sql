CREATE OR REPLACE VIEW vw_band_members AS
SELECT b.band_name
      ,a.first_name || ' ' || a.last_name AS artist_name
      ,a.birth_place || ' ,' || a.birth_date AS birth_information
  FROM artists a
  JOIN artist_band_connections ar
    ON a.id = ar.artist_id
  JOIN bands b
    ON ar.band_id = b.id;
