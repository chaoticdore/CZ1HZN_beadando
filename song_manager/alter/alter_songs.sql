ALTER TABLE songs ADD FOREIGN KEY (album_id) REFERENCES albums (id);

ALTER TABLE songs ADD FOREIGN KEY (band_id) REFERENCES bands (id);
