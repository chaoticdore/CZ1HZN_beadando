CREATE TABLE genres_h(
       genre_id                NUMBER,
       genre_name              VARCHAR2(250 char),
       id                      NUMBER,
       modifying_user          VARCHAR2(250),
       modification_time       TIMESTAMP(6),
       creating_user           VARCHAR2(250),
       creation_time           TIMESTAMP(6),
       dml_type                 CHAR(1),
       row_version             NUMBER
);
