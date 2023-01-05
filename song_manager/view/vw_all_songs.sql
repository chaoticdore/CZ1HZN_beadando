CREATE OR REPLACE VIEW vw_all_songs AS
SELECT s.song_name
      ,s.release_date
      ,s.song_length AS length_in_seconds
      ,a.album_name
      ,b.band_name
      ,p.publisher_name
  FROM songs s
  JOIN bands b
    ON s.band_id = b.id
  JOIN albums a
    ON s.album_id = a.id
  JOIN publishers p
    ON a.publisher_id = p.id;
