CREATE OR REPLACE PACKAGE pkg_songs IS

  PROCEDURE insert_song(p_band_name    IN VARCHAR2
                       ,p_album_name   IN VARCHAR2
                       ,p_song_name    IN VARCHAR2
                       ,p_release_date IN DATE
                       ,p_song_length  IN NUMBER);

  PROCEDURE delete_song(p_band_name    IN VARCHAR2
                       ,p_album_name   IN VARCHAR2
                       ,p_song_name    IN VARCHAR2
                       ,p_release_date IN DATE
                       ,p_song_length  IN NUMBER);

  FUNCTION does_song_exist(p_band_name    VARCHAR2
                          ,p_album_name   VARCHAR2
                          ,p_song_name    VARCHAR2
                          ,p_release_date DATE
                          ,p_song_length  NUMBER) RETURN BOOLEAN;

  FUNCTION number_of_songs_from_band(p_band_name VARCHAR2) RETURN NUMBER;

  FUNCTION length_of_all_songs_from_band(p_band_name VARCHAR2) RETURN NUMBER;

END pkg_songs;
/
CREATE OR REPLACE PACKAGE BODY pkg_songs IS

  v_temp_band_id      NUMBER;
  v_temp_album_exists NUMBER;
  v_temp_album_id     NUMBER;
  v_temp_song_exists  NUMBER;

  PROCEDURE insert_song(p_band_name    IN VARCHAR2
                       ,p_album_name   IN VARCHAR2
                       ,p_song_name    IN VARCHAR2
                       ,p_release_date DATE
                       ,p_song_length  NUMBER) IS
  
  BEGIN
    IF NOT pkg_bands.does_band_exist(p_band_name)
    THEN
      raise_application_error(pkg_exception.gc_band_not_found,
                              'The band' || '"' || p_band_name ||
                              '" was not found, please make sure to add the band before trying to add songs from them.');
    ELSE
      --SELECT b.id
      v_temp_band_id := pkg_bands.id_of_band(p_band_name);
      --FROM bands b
      -- WHERE b.band_name = p_band_name;
    END IF;
    SELECT COUNT(a.id)
      INTO v_temp_album_exists
      FROM bands b
      JOIN albums a
        ON a.band_id = b.id
     WHERE b.band_name = p_band_name
       AND a.album_name = p_album_name;
    IF v_temp_album_exists = 0
    THEN
      raise_application_error(pkg_exception.gc_album_not_found,
                              'The album "' || p_album_name ||
                              '" was not found from the band " ' ||
                              p_band_name ||
                              '", please make sure to add the album before trying to add songs into it.');
    ELSE
      SELECT a.id
        INTO v_temp_album_id
        FROM albums a
       WHERE a.album_name = p_album_name;
    END IF;
    /*SELECT COUNT(s.id)
     INTO v_temp_song_exists
     FROM songs s
     JOIN albums a
       ON s.album_id = a.id
     JOIN bands b
       ON s.band_id = b.id
    WHERE b.band_name = p_band_name
      AND a.album_name = p_album_name
      AND s.song_name = p_song_name
      AND s.release_date = p_release_date
      AND s.song_length = p_song_length;*/
    IF does_song_exist(p_band_name,
                       p_album_name,
                       p_song_name,
                       p_release_date,
                       p_song_length)
    THEN
      raise_application_error(pkg_exception.gc_songs_already_exists,
                              'The song "' || p_song_name ||
                              '" already exists with these parameters: ' ||
                              chr(10) || 'Band name: ' || p_band_name ||
                              chr(10) || 'Album name: ' || p_album_name ||
                              chr(10) || 'Release date: ' || p_release_date ||
                              chr(10) || 'Length of the song: ' ||
                              p_song_length);
    ELSE
      INSERT INTO songs
        (album_id
        ,band_id
        ,song_name
        ,release_date
        ,song_length)
      VALUES
        (v_temp_album_id
        ,v_temp_band_id
        ,p_song_name
        ,p_release_date
        ,p_song_length);
    END IF;
  END insert_song;

  ------------------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE delete_song(p_band_name    IN VARCHAR2
                       ,p_album_name   IN VARCHAR2
                       ,p_song_name    IN VARCHAR2
                       ,p_release_date DATE
                       ,p_song_length  NUMBER) IS
  BEGIN
    IF NOT pkg_bands.does_band_exist(p_band_name)
    THEN
      raise_application_error(pkg_exception.gc_band_not_found,
                              'The band' || '"' || p_band_name ||
                              '" was not found, please make sure to add the band before trying to delete songs from them.');
    ELSE
      SELECT b.id
        INTO v_temp_band_id
        FROM bands b
       WHERE b.band_name = p_band_name;
    END IF;
    SELECT COUNT(a.id)
      INTO v_temp_album_exists
      FROM bands b
      JOIN albums a
        ON a.band_id = b.id
     WHERE b.band_name = p_band_name
       AND a.album_name = p_album_name;
    IF v_temp_album_exists = 0
    THEN
      raise_application_error(pkg_exception.gc_album_not_found,
                              'The album "' || p_album_name ||
                              '" was not found from the band " ' ||
                              p_band_name ||
                              '", please make sure to add the album before trying to delete songs from it.');
    ELSE
      SELECT a.id
        INTO v_temp_album_id
        FROM albums a
       WHERE a.album_name = p_album_name;
    END IF;
    /*SELECT COUNT(s.id)
     INTO v_temp_song_exists
     FROM songs s
     JOIN albums a
       ON s.album_id = a.id
     JOIN bands b
       ON s.band_id = b.id
    WHERE b.band_name = p_band_name
      AND a.album_name = p_album_name
      AND s.song_name = p_song_name
      AND s.release_date = p_release_date
      AND s.song_length = p_song_length;*/
    IF does_song_exist(p_band_name,
                       p_album_name,
                       p_song_name,
                       p_release_date,
                       p_song_length)
    THEN
      DELETE FROM songs s
       WHERE s.album_id = v_temp_album_id
         AND s.band_id = v_temp_band_id
         AND s.song_name = p_song_name
         AND s.release_date = p_release_date
         AND s.song_length = p_song_length;
    ELSE
      raise_application_error(pkg_exception.gc_song_not_found,
                              'The song "' || p_song_name ||
                              '" was not found with these parameters: ' ||
                              chr(10) || 'Band name: ' || p_band_name ||
                              chr(10) || 'Album name: ' || p_album_name ||
                              chr(10) || 'Release date: ' || p_release_date ||
                              chr(10) || 'Length of the song: ' ||
                              p_song_length);
    END IF;
  END;

  ----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION does_song_exist(p_band_name    VARCHAR2
                          ,p_album_name   VARCHAR2
                          ,p_song_name    VARCHAR2
                          ,p_release_date DATE
                          ,p_song_length  NUMBER) RETURN BOOLEAN IS
  
  BEGIN
    SELECT COUNT(s.id)
      INTO v_temp_song_exists
      FROM songs s
      JOIN albums a
        ON s.album_id = a.id
      JOIN bands b
        ON s.band_id = b.id
     WHERE b.band_name = p_band_name
       AND a.album_name = p_album_name
       AND s.song_name = p_song_name
       AND s.release_date = p_release_date
       AND s.song_length = p_song_length;
    IF v_temp_song_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

  ----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION number_of_songs_from_band(p_band_name VARCHAR2) RETURN NUMBER IS
  
    v_temp_number_of_songs NUMBER;
  
  BEGIN
    IF pkg_bands.does_band_exist(p_band_name)
    THEN
      SELECT COUNT(*)
        INTO v_temp_number_of_songs
        FROM bands b
        JOIN songs s
          ON b.id = s.band_id
       WHERE b.band_name = p_band_name;
      RETURN v_temp_number_of_songs;
    ELSE
      raise_application_error(pkg_exception.gc_band_not_found,
                              'The band "' || p_band_name ||
                              '" was not found.');
    END IF;
  
  END;

  ----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION length_of_all_songs_from_band(p_band_name VARCHAR2) RETURN NUMBER IS
  
    v_length_of_all_songs NUMBER;
  
  BEGIN
    SELECT SUM(s.song_length)
      INTO v_length_of_all_songs
      FROM songs s
      JOIN bands b
        ON s.band_id = b.id
     WHERE b.id = pkg_bands.id_of_band(p_band_name);
    IF v_length_of_all_songs > 0
    THEN
      RETURN v_length_of_all_songs;
    ELSE
      RETURN 0;
    END IF;
  END;

END pkg_songs;
/
