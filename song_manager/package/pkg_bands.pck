CREATE OR REPLACE PACKAGE pkg_bands IS

  PROCEDURE insert_band(p_band_name IN VARCHAR2);

  PROCEDURE insert_artist(p_band_name   IN VARCHAR2
                         ,p_first_name  IN VARCHAR2
                         ,p_last_name   IN VARCHAR2
                         ,p_birth_place IN VARCHAR2
                         ,p_birth_date  IN DATE);

  PROCEDURE change_artist_name(p_band_name       IN VARCHAR2
                              ,p_curr_first_name IN VARCHAR2
                              ,p_curr_last_name  IN VARCHAR2
                              ,p_birth_place     IN VARCHAR2
                              ,p_birth_date      IN DATE
                              ,p_new_first_name  IN VARCHAR2
                              ,p_new_last_name   IN VARCHAR2);

  FUNCTION does_band_exist(p_band_name VARCHAR2) RETURN BOOLEAN;

  FUNCTION does_artist_exist(p_band_name   VARCHAR2
                            ,p_first_name  VARCHAR2
                            ,p_last_name   VARCHAR2
                            ,p_birth_place VARCHAR2
                            ,p_birth_date  DATE) RETURN BOOLEAN;

  FUNCTION id_of_artist(p_band_name   VARCHAR2
                       ,p_first_name  VARCHAR2
                       ,p_last_name   VARCHAR2
                       ,p_birth_place VARCHAR2
                       ,p_birth_date  DATE) RETURN NUMBER;

  FUNCTION id_of_band(p_band_name VARCHAR2) RETURN NUMBER;

END pkg_bands;
/
CREATE OR REPLACE PACKAGE BODY pkg_bands IS

  v_temp_band_id   NUMBER;
  v_temp_artist_id NUMBER;

  PROCEDURE insert_band(p_band_name IN VARCHAR2) IS
  BEGIN
    IF does_band_exist(p_band_name)
    THEN
      raise_application_error(pkg_exception.gc_band_already_exists,
                              'The band "' || p_band_name ||
                              '" already exists.');
    ELSE
      INSERT INTO bands (band_name) VALUES (p_band_name);
    END IF;
  
  END insert_band;

  --------------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE insert_artist(p_band_name   IN VARCHAR2
                         ,p_first_name  IN VARCHAR2
                         ,p_last_name   IN VARCHAR2
                         ,p_birth_place IN VARCHAR2
                         ,p_birth_date  IN DATE) IS
  
  BEGIN
    IF NOT does_band_exist(p_band_name)
    THEN
      raise_application_error(pkg_exception.gc_band_not_found,
                              'The band "' || p_band_name ||
                              '" was not found.');
    END IF;
    IF does_artist_exist(p_band_name,
                         p_first_name,
                         p_last_name,
                         p_birth_place,
                         p_birth_date)
    THEN
      raise_application_error(pkg_exception.gc_artist_already_exists,
                              'The artist "' || p_first_name || ' ' ||
                              p_last_name ||
                              '" already exists in the band: "' ||
                              p_band_name || '" with these parameters: ' ||
                              chr(10) || 'Birth place: ' || p_birth_place ||
                              chr(10) || 'Birth date: ' || p_birth_date);
    ELSE
      INSERT INTO artists
        (first_name
        ,last_name
        ,birth_place
        ,birth_date)
      VALUES
        (p_first_name
        ,p_last_name
        ,p_birth_place
        ,p_birth_date);
      SELECT a.id
        INTO v_temp_artist_id
        FROM artists a
       WHERE a.first_name = p_first_name
         AND a.last_name = p_last_name
         AND a.birth_place = p_birth_place
         AND a.birth_date = p_birth_date;
    
      INSERT INTO artist_band_connections
        (artist_id
        ,band_id)
      VALUES
        (v_temp_artist_id
        ,id_of_band(p_band_name));
    END IF;
  END insert_artist;
  ------------------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE change_artist_name(p_band_name       IN VARCHAR2
                              ,p_curr_first_name IN VARCHAR2
                              ,p_curr_last_name  IN VARCHAR2
                              ,p_birth_place     IN VARCHAR2
                              ,p_birth_date      IN DATE
                              ,p_new_first_name  IN VARCHAR2
                              ,p_new_last_name   IN VARCHAR2) IS
  BEGIN
    IF NOT does_band_exist(p_band_name)
    THEN
      raise_application_error(pkg_exception.gc_band_not_found,
                              'The band "' || p_band_name ||
                              '" was not found.');
    END IF;
    IF does_artist_exist(p_band_name,
                         p_curr_first_name,
                         p_curr_last_name,
                         p_birth_place,
                         p_birth_date)
    
    THEN
      SELECT a.id
        INTO v_temp_artist_id
        FROM artists a
        JOIN artist_band_connections con
          ON con.artist_id = a.id
        JOIN bands b
          ON con.band_id = b.id
       WHERE b.id = id_of_band(p_band_name)
         AND a.first_name = p_curr_first_name
         AND a.last_name = p_curr_last_name
         AND a.birth_place = p_birth_place
         AND a.birth_date = p_birth_date;
    
      UPDATE artists a
         SET a.first_name = p_new_first_name
            ,a.last_name  = p_new_last_name
       WHERE a.id = v_temp_artist_id;
    ELSE
      raise_application_error(pkg_exception.gc_artist_not_found,
                              'Artist "' || p_curr_first_name || ' ' ||
                              p_curr_last_name ||
                              'was not found in the band "' || p_band_name || '.');
    END IF;
  
  END;

  ------------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION does_band_exist(p_band_name VARCHAR2) RETURN BOOLEAN IS
  
    v_temp_band_exists NUMBER;
  
  BEGIN
    SELECT COUNT(b.id)
      INTO v_temp_band_exists
      FROM bands b
     WHERE b.band_name = p_band_name;
    IF v_temp_band_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

  ------------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION does_artist_exist(p_band_name   VARCHAR2
                            ,p_first_name  VARCHAR2
                            ,p_last_name   VARCHAR2
                            ,p_birth_place VARCHAR2
                            ,p_birth_date  DATE) RETURN BOOLEAN IS
    v_temp_artist_exists NUMBER;
  BEGIN
    SELECT COUNT(a.id)
      INTO v_temp_artist_exists
      FROM artists a
      JOIN artist_band_connections con
        ON con.artist_id = a.id
      JOIN bands b
        ON con.band_id = b.id
     WHERE b.band_name = p_band_name
       AND a.first_name = p_first_name
       AND a.last_name = p_last_name
       AND a.birth_place = p_birth_place
       AND a.birth_date = p_birth_date;
    IF v_temp_artist_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION id_of_artist(p_band_name   VARCHAR2
                       ,p_first_name  VARCHAR2
                       ,p_last_name   VARCHAR2
                       ,p_birth_place VARCHAR2
                       ,p_birth_date  DATE) RETURN NUMBER IS
  
    v_temp_artist_id NUMBER;
  
  BEGIN
    SELECT a.id
      INTO v_temp_artist_id
      FROM artists a
      JOIN artist_band_connections con
        ON con.artist_id = a.id
      JOIN bands b
        ON con.band_id = b.id
     WHERE b.id = id_of_band(p_band_name)
       AND a.first_name = p_first_name
       AND a.last_name = p_last_name
       AND a.birth_place = p_birth_place
       AND a.birth_date = p_birth_date;
    RETURN v_temp_artist_id;
  END;

  ------------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION id_of_band(p_band_name VARCHAR2) RETURN NUMBER IS
  
    v_temp_band_id NUMBER;
  
  BEGIN
    SELECT b.id
      INTO v_temp_band_id
      FROM bands b
     WHERE b.band_name = p_band_name;
    RETURN v_temp_band_id;
  END;

END pkg_bands;
/
