DECLARE
  l_cnt NUMBER;
BEGIN
  SELECT COUNT(*) INTO l_cnt FROM dba_users t WHERE t.username='SONG_MANAGER';
  IF l_cnt=1 THEN 
    EXECUTE IMMEDIATE 'DROP USER song_manager CASCADE';
  END IF;
END;
/
CREATE USER song_manager 
  IDENTIFIED BY 12345678
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON users
;

GRANT CREATE SESSION TO song_manager;
GRANT CREATE TABLE TO song_manager;
GRANT CREATE VIEW TO song_manager;
GRANT CREATE SEQUENCE TO song_manager;
GRANT CREATE PROCEDURE TO song_manager;
GRANT CREATE TYPE TO song_manager;
GRANT EXECUTE ON dbms_lock TO song_manager;
GRANT CREATE TRIGGER TO song_manager;
