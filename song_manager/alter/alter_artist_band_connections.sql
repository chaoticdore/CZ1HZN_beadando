ALTER TABLE artist_band_connections ADD FOREIGN KEY (artist_id) REFERENCES artists (id);

ALTER TABLE artist_band_connections ADD FOREIGN KEY (band_id) REFERENCES bands (id);
