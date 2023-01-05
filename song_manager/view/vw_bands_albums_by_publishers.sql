CREATE OR REPLACE VIEW vw_bands_albums_by_publishers AS
SELECT b.band_name, a.album_name, a.release_date, p.publisher_name
FROM bands b
JOIN albums a
ON a.band_id = b.id
JOIN publishers p
ON a.publisher_id = p.id
ORDER BY p.publisher_name;
