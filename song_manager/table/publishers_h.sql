CREATE TABLE publishers_h(
       publisher_id                NUMBER,
       publisher_name              VARCHAR2(250 char),
       headquarters                VARCHAR2(250 char),
       ceo_first_name              VARCHAR2(250 char),
       ceo_last_name               VARCHAR2(250 char),
       foundation_date             DATE,
       id                          NUMBER,
       modifying_user              VARCHAR2(250),
       modification_time           TIMESTAMP(6),
       creating_user               VARCHAR2(250),
       creation_time               TIMESTAMP(6),
       dml_type                     CHAR(1),
       row_version                 NUMBER
);
