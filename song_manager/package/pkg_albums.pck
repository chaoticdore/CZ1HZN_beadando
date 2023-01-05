CREATE OR REPLACE PACKAGE pkg_albums IS

  PROCEDURE insert_album(p_band_name      IN VARCHAR2
                        ,p_album_name     IN VARCHAR2
                        ,p_release_date   IN DATE
                        ,p_genre_name     IN VARCHAR2
                        ,p_publisher_name IN VARCHAR2);

  FUNCTION does_album_exist(p_band_name      VARCHAR2
                           ,p_album_name     VARCHAR2
                           ,p_release_date   DATE
                           ,p_genre_name     VARCHAR2
                           ,p_publisher_name VARCHAR2) RETURN BOOLEAN;

  FUNCTION does_album_exist_no_genre(p_band_name      VARCHAR2
                                    ,p_album_name     VARCHAR2
                                    ,p_release_date   DATE
                                    ,p_publisher_name VARCHAR2)
    RETURN BOOLEAN;

  FUNCTION id_of_album(p_band_name      VARCHAR2
                      ,p_album_name     VARCHAR2
                      ,p_release_date   DATE
                      ,p_publisher_name VARCHAR2) RETURN NUMBER;

  FUNCTION songs_of_album(p_band_name      VARCHAR2
                         ,p_album_name     VARCHAR2
                         ,p_release_date   DATE
                         ,p_publisher_name VARCHAR2) RETURN ty_songs_by_album;

END pkg_albums;
/
CREATE OR REPLACE PACKAGE BODY pkg_albums IS

  v_temp_band_id      NUMBER;
  v_temp_publisher_id NUMBER;
  v_temp_genre_id     NUMBER;
  v_temp_album_id     NUMBER;

  PROCEDURE insert_album(p_band_name      IN VARCHAR2
                        ,p_album_name     IN VARCHAR2
                        ,p_release_date   IN DATE
                        ,p_genre_name     IN VARCHAR2
                        ,p_publisher_name IN VARCHAR2) IS
  BEGIN
    /*SELECT COUNT(b.id)
     INTO v_temp_band_exists
     FROM bands b
    WHERE b.band_name = p_band_name;*/
    IF NOT pkg_bands.does_band_exist(p_band_name)
    THEN
      raise_application_error(pkg_exception.gc_band_not_found,
                              'The band' || '"' || p_band_name ||
                              '" was not found, please make sure to add the band before trying to add albums from them.');
    ELSE
    
      v_temp_band_id := pkg_bands.id_of_band(p_band_name);
    
    END IF;
  
    IF NOT pkg_publishers.does_publisher_exist_by_name(p_publisher_name)
    THEN
      raise_application_error(pkg_exception.gc_publisher_not_found,
                              'The publisher' || '"' || p_publisher_name ||
                              '" was not found, please make sure to add them.');
    ELSE
      SELECT p.id
        INTO v_temp_publisher_id
        FROM publishers p
       WHERE p.publisher_name = p_publisher_name;
    END IF;
  
    IF NOT pkg_genres.does_genre_exist(p_genre_name)
    THEN
      raise_application_error(pkg_exception.gc_genre_not_found,
                              'The genre: ' || p_genre_name ||
                              ' was not found, please add it.');
    ELSE
    
      v_temp_genre_id := pkg_genres.id_of_genre(p_genre_name);
    
    END IF;
    IF does_album_exist(p_band_name,
                        p_album_name,
                        p_release_date,
                        p_genre_name,
                        p_publisher_name)
    THEN
      raise_application_error(pkg_exception.gc_album_already_exists,
                              'The album' || '"' || p_album_name ||
                              '" already exists with these parameters:' ||
                              chr(10) || 'Band name: ' || p_band_name ||
                              chr(10) || 'Genre: ' || p_genre_name ||
                              chr(10) || 'Publisher name: ' ||
                              p_publisher_name || chr(10) ||
                              'Release date: ' || p_release_date);
    ELSE
      INSERT INTO albums
        (band_id
        ,album_name
        ,release_date
        ,publisher_id)
      VALUES
        (v_temp_band_id
        ,p_album_name
        ,p_release_date
        ,v_temp_publisher_id);
    
      SELECT a.id
        INTO v_temp_album_id
        FROM albums a
        JOIN bands b
          ON a.band_id = b.id
       WHERE a.album_name = p_album_name
         AND a.release_date = p_release_date
         AND a.publisher_id = v_temp_publisher_id
         AND b.band_name = p_band_name;
    
      INSERT INTO genre_album_connections
        (genre_id
        ,album_id)
      VALUES
        (v_temp_genre_id
        ,v_temp_album_id);
    END IF;
  
  END;

  ---------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION does_album_exist(p_band_name      VARCHAR2
                           ,p_album_name     VARCHAR2
                           ,p_release_date   DATE
                           ,p_genre_name     VARCHAR2
                           ,p_publisher_name VARCHAR2) RETURN BOOLEAN IS
  
    v_temp_album_exists NUMBER;
  
  BEGIN
    SELECT COUNT(a.id)
      INTO v_temp_album_exists
      FROM albums a
      JOIN bands b
        ON a.band_id = b.id
      JOIN publishers p
        ON a.publisher_id = p.id
      JOIN genre_album_connections con
        ON con.album_id = a.id
      JOIN genres g
        ON con.genre_id = g.id
     WHERE b.band_name = p_band_name
       AND p.publisher_name = p_publisher_name
       AND a.album_name = p_album_name
       AND a.release_date = p_release_date
       AND g.genre_name = p_genre_name;
    IF v_temp_album_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
  ----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION does_album_exist_no_genre(p_band_name      VARCHAR2
                                    ,p_album_name     VARCHAR2
                                    ,p_release_date   DATE
                                    ,p_publisher_name VARCHAR2)
    RETURN BOOLEAN IS
  
    v_temp_album_exists NUMBER;
  
  BEGIN
    SELECT COUNT(a.id)
      INTO v_temp_album_exists
      FROM albums a
      JOIN bands b
        ON a.band_id = b.id
      JOIN publishers p
        ON a.publisher_id = p.id
     WHERE b.band_name = p_band_name
       AND p.publisher_name = p_publisher_name
       AND a.album_name = p_album_name
       AND a.release_date = p_release_date;
    IF v_temp_album_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

  ----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION id_of_album(p_band_name      VARCHAR2
                      ,p_album_name     VARCHAR2
                      ,p_release_date   DATE
                      ,p_publisher_name VARCHAR2) RETURN NUMBER IS
  
    v_temp_band_id      NUMBER;
    v_temp_publisher_id NUMBER;
  
  BEGIN
    v_temp_publisher_id := pkg_publishers.id_of_publisher_by_name(p_publisher_name);
  
    SELECT a.id
      INTO v_temp_band_id
      FROM albums a
      JOIN bands b
        ON a.band_id = b.id
     WHERE a.album_name = p_album_name
       AND a.release_date = p_release_date
       AND a.publisher_id = v_temp_publisher_id
       AND b.band_name = p_band_name;
    RETURN v_temp_band_id;
  END;

  -----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION songs_of_album(p_band_name      VARCHAR2
                         ,p_album_name     VARCHAR2
                         ,p_release_date   DATE
                         ,p_publisher_name VARCHAR2) RETURN ty_songs_by_album IS
  
    v_songs_by_album ty_songs_by_album;
    v_songs_in_album ty_songs_in_album_l;
    v_temp_band_id   NUMBER;
    v_temp_album_id  NUMBER;
  
  BEGIN
    IF does_album_exist_no_genre(p_band_name,
                                 p_album_name,
                                 p_release_date,
                                 p_publisher_name)
    THEN
      v_temp_band_id  := pkg_bands.id_of_band(p_band_name);
      v_temp_album_id := id_of_album(p_band_name,
                                     p_album_name,
                                     p_release_date,
                                     p_publisher_name);
    
      SELECT s.song_name
        BULK COLLECT
        INTO v_songs_in_album
        FROM songs s
        JOIN albums a
          ON s.album_id = v_temp_album_id
       WHERE s.band_id = v_temp_band_id
         AND a.album_name = p_album_name;
    
      v_songs_by_album := ty_songs_by_album(p_band_name,
                                            p_album_name,
                                            v_songs_in_album);
    
      RETURN v_songs_by_album;
    ELSE
      raise_application_error(pkg_exception.gc_album_not_found,
                              'The album "' || p_album_name ||
                              '" was not found');
    END IF;
  END;

END pkg_albums;
/
