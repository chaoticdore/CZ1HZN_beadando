CREATE TABLE albums_h(
       album_id                NUMBER,
       album_name              VARCHAR2(250 char),
       band_id                 NUMBER,
       release_date            DATE,
       publisher_id            NUMBER,
       id                      NUMBER,
       modifying_user          VARCHAR2(250),
       modification_time       TIMESTAMP(6),
       creating_user           VARCHAR2(250),
       creation_time           TIMESTAMP(6),
       dml_type                 CHAR(1),
       row_version             NUMBER
);
