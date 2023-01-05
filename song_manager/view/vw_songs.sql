CREATE OR REPLACE VIEW vw_songs AS
SELECT s.id,
       s.album_id,
       s.band_id,
       s.song_name,
       s.release_date,
       s.song_length
FROM songs s;
