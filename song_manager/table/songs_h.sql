CREATE TABLE songs_h(
       song_id                NUMBER,
       song_name              VARCHAR2(250 char),
       album_id               NUMBER,
       band_id                NUMBER,
       release_date           DATE,
       song_length            NUMBER,
       id                     NUMBER,
       modifying_user         VARCHAR2(250),
       modification_time      TIMESTAMP(6),
       creating_user          VARCHAR2(250),
       creation_time          TIMESTAMP(6),
       dml_type                CHAR(1),
       row_version            NUMBER
);
