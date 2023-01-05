CREATE OR REPLACE VIEW vw_albums AS
SELECT a.id,
       a.band_id,
       a.album_name,
       a.release_date,
       a.publisher_id
FROM albums a;
