CREATE TABLE artists_h(
       artist_id                NUMBER,
       first_name               VARCHAR2(250 char),
       last_name                VARCHAR2(250 char),
       birth_place              VARCHAR2(250 char),
       birth_date               DATE,
       id                       NUMBER,
       modifying_user           VARCHAR2(250),
       modification_time        TIMESTAMP(6),
       creating_user            VARCHAR2(250),
       creation_time            TIMESTAMP(6),
       dml_type                  CHAR(1),
       row_version              NUMBER
);
