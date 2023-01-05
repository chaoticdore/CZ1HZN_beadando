ALTER TABLE genre_album_connections ADD FOREIGN KEY (genre_id) REFERENCES genres (id);

ALTER TABLE genre_album_connections ADD FOREIGN KEY (album_id) REFERENCES albums (id);
