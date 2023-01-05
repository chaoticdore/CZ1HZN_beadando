ALTER TABLE albums ADD FOREIGN KEY (band_id) REFERENCES bands (id);

ALTER TABLE albums ADD FOREIGN KEY (publisher_id) REFERENCES publishers (id);
