CREATE OR REPLACE PACKAGE pkg_genres IS

  PROCEDURE insert_genre(p_genre_name IN VARCHAR2);

  PROCEDURE delete_genre(p_genre_name IN VARCHAR2);

  PROCEDURE add_genre_to_album(p_genre_name     IN VARCHAR2
                              ,p_album_name     IN VARCHAR2
                              ,p_band_name      IN VARCHAR2
                              ,p_release_date   IN VARCHAR2
                              ,p_publisher_name IN VARCHAR2);

  FUNCTION does_genre_exist(p_genre_name VARCHAR2) RETURN BOOLEAN;

  FUNCTION id_of_genre(p_genre_name VARCHAR2) RETURN NUMBER;

END pkg_genres;
/
CREATE OR REPLACE PACKAGE BODY pkg_genres IS

  v_temp_genre_exists NUMBER;

  PROCEDURE insert_genre(p_genre_name IN VARCHAR2) IS
  BEGIN
    /*SELECT COUNT(g.id)
     INTO v_temp_genre_exists
     FROM genres g
    WHERE g.genre_name = p_genre_name;*/
    IF does_genre_exist(p_genre_name)
    THEN
      raise_application_error(pkg_exception.gc_genre_already_exists,
                              'The genre' || '"' || p_genre_name ||
                              '" already exists.');
    ELSE
      INSERT INTO genres (genre_name) VALUES (p_genre_name);
    END IF;
  END;

  ---------------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE delete_genre(p_genre_name IN VARCHAR2) IS
  BEGIN
    /*SELECT COUNT(g.id)
     INTO v_temp_genre_exists
     FROM genres g
    WHERE g.genre_name = p_genre_name;*/
    IF does_genre_exist(p_genre_name)
    THEN
      DELETE FROM genres g WHERE g.genre_name = p_genre_name;
    ELSE
      raise_application_error(pkg_exception.gc_genre_not_found,
                              'The genre' || '"' || p_genre_name ||
                              '" was not found.');
    END IF;
  END;

  ---------------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE add_genre_to_album(p_genre_name     IN VARCHAR2
                              ,p_album_name     IN VARCHAR2
                              ,p_band_name      IN VARCHAR2
                              ,p_release_date   IN VARCHAR2
                              ,p_publisher_name IN VARCHAR2) IS
  
    v_temp_album_id              NUMBER;
    v_temp_genre_id              NUMBER;
    v_temp_does_connection_exist NUMBER;
  
  BEGIN
     
    IF NOT does_genre_exist(p_genre_name)
    THEN
      raise_application_error(pkg_exception.gc_genre_not_found,
                              'The genre "' || p_genre_name ||
                              '" was not found.');
    ELSIF NOT pkg_bands.does_band_exist(p_band_name)
    THEN
      raise_application_error(pkg_exception.gc_band_not_found,
                              'The band "' || p_band_name ||
                              '" was not found.');
    ELSIF NOT pkg_publishers.does_publisher_exist_by_name(p_publisher_name)
    THEN
      raise_application_error(pkg_exception.gc_publisher_not_found,
                              'The publisher "' || p_publisher_name ||
                              '" was not found.');
    ELSIF NOT pkg_albums.does_album_exist_no_genre(p_band_name,
                                                   p_album_name,
                                                   p_release_date,
                                                   p_publisher_name)
    THEN
      raise_application_error(pkg_exception.gc_album_not_found,
                              'The album "' || p_album_name ||
                              '" was not found.');
    ELSE
    
      v_temp_genre_id := pkg_genres.id_of_genre(p_genre_name);
      v_temp_album_id := pkg_albums.id_of_album(p_band_name,
                                                p_album_name,
                                                p_release_date,
                                                p_publisher_name);
    END IF;
  
    SELECT COUNT(con.id)
      INTO v_temp_does_connection_exist
      FROM genre_album_connections con
     WHERE con.genre_id = v_temp_genre_id
       AND con.album_id = v_temp_album_id;
  
    IF v_temp_does_connection_exist > 0
    THEN
      raise_application_error(pkg_exception.gc_connection_already_exists,
                              'The album "' || p_album_name ||
                              '" from the band "' || p_band_name ||
                              '" already has the genre "' || p_genre_name || '".');
    ELSE
      INSERT INTO genre_album_connections
        (genre_id
        ,album_id)
      VALUES
        (v_temp_genre_id
        ,v_temp_album_id);
    END IF;
  
  END;

  ---------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION does_genre_exist(p_genre_name VARCHAR2) RETURN BOOLEAN IS
  
    v_temp_genre_exists NUMBER;
  
  BEGIN
    SELECT COUNT(g.id)
      INTO v_temp_genre_exists
      FROM genres g
     WHERE g.genre_name = p_genre_name;
    IF v_temp_genre_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

  ---------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION id_of_genre(p_genre_name VARCHAR2) RETURN NUMBER IS
  
    v_temp_genre_id NUMBER;
  
  BEGIN
    SELECT g.id
      INTO v_temp_genre_id
      FROM genres g
     WHERE g.genre_name = p_genre_name;
    RETURN v_temp_genre_id;
  END;

END pkg_genres;
/
