ALTER TABLE songs ADD modifying_user VARCHAR2(250);
ALTER TABLE songs ADD modification_time TIMESTAMP;
ALTER TABLE songs ADD creating_user VARCHAR2(250);
ALTER TABLE songs ADD creation_time TIMESTAMP;
ALTER TABLE songs ADD dml_type CHAR(1);
ALTER TABLE songs ADD row_version NUMBER;

ALTER TABLE bands ADD modifying_user VARCHAR2(250);
ALTER TABLE bands ADD modification_time TIMESTAMP;
ALTER TABLE bands ADD creating_user VARCHAR2(250);
ALTER TABLE bands ADD creation_time TIMESTAMP;
ALTER TABLE bands ADD dml_type CHAR(1);
ALTER TABLE bands ADD row_version NUMBER;

ALTER TABLE artists ADD modifying_user VARCHAR2(250);
ALTER TABLE artists ADD modification_time TIMESTAMP;
ALTER TABLE artists ADD creating_user VARCHAR2(250);
ALTER TABLE artists ADD creation_time TIMESTAMP;
ALTER TABLE artists ADD dml_type CHAR(1);
ALTER TABLE artists ADD row_version NUMBER;

ALTER TABLE artist_band_connections ADD modifying_user VARCHAR2(250);
ALTER TABLE artist_band_connections ADD modification_time TIMESTAMP;
ALTER TABLE artist_band_connections ADD creating_user VARCHAR2(250);
ALTER TABLE artist_band_connections ADD creation_time TIMESTAMP;
ALTER TABLE artist_band_connections ADD dml_type CHAR(1);
ALTER TABLE artist_band_connections ADD row_version NUMBER;

ALTER TABLE albums ADD modifying_user VARCHAR2(250);
ALTER TABLE albums ADD modification_time TIMESTAMP;
ALTER TABLE albums ADD creating_user VARCHAR2(250);
ALTER TABLE albums ADD creation_time TIMESTAMP;
ALTER TABLE albums ADD dml_type CHAR(1);
ALTER TABLE albums ADD row_version NUMBER;

ALTER TABLE publishers ADD modifying_user VARCHAR2(250);
ALTER TABLE publishers ADD modification_time TIMESTAMP;
ALTER TABLE publishers ADD creating_user VARCHAR2(250);
ALTER TABLE publishers ADD creation_time TIMESTAMP;
ALTER TABLE publishers ADD dml_type CHAR(1);
ALTER TABLE publishers ADD row_version NUMBER;

ALTER TABLE genres ADD modifying_user VARCHAR2(250);
ALTER TABLE genres ADD modification_time TIMESTAMP;
ALTER TABLE genres ADD creating_user VARCHAR2(250);
ALTER TABLE genres ADD creation_time TIMESTAMP;
ALTER TABLE genres ADD dml_type CHAR(1);
ALTER TABLE genres ADD row_version NUMBER;

ALTER TABLE genre_album_connections ADD modifying_user VARCHAR2(250);
ALTER TABLE genre_album_connections ADD modification_time TIMESTAMP;
ALTER TABLE genre_album_connections ADD creating_user VARCHAR2(250);
ALTER TABLE genre_album_connections ADD creation_time TIMESTAMP;
ALTER TABLE genre_album_connections ADD dml_type CHAR(1);
ALTER TABLE genre_album_connections ADD row_version NUMBER;
