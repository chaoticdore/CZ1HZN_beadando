CREATE OR REPLACE PACKAGE pkg_publishers IS

  PROCEDURE insert_publisher(p_publisher_name  IN VARCHAR2
                            ,p_headquarters    IN VARCHAR2
                            ,p_ceo_first_name  IN VARCHAR2
                            ,p_ceo_last_name   IN VARCHAR2
                            ,p_foundation_date IN DATE);

  FUNCTION does_publisher_exist(p_publisher_name  VARCHAR2
                               ,p_headquarters    VARCHAR2
                               ,p_ceo_first_name  VARCHAR2
                               ,p_ceo_last_name   VARCHAR2
                               ,p_foundation_date DATE) RETURN BOOLEAN;

  FUNCTION does_publisher_exist_by_name(p_publisher_name VARCHAR2)
    RETURN BOOLEAN;

  FUNCTION id_of_publisher_by_name(p_publisher_name VARCHAR2) RETURN NUMBER;

END pkg_publishers;
/
CREATE OR REPLACE PACKAGE BODY pkg_publishers IS

  PROCEDURE insert_publisher(p_publisher_name  IN VARCHAR2
                            ,p_headquarters    IN VARCHAR2
                            ,p_ceo_first_name  IN VARCHAR2
                            ,p_ceo_last_name   IN VARCHAR2
                            ,p_foundation_date IN DATE) IS
  BEGIN
    IF does_publisher_exist(p_publisher_name,
                            p_headquarters,
                            p_ceo_first_name,
                            p_ceo_last_name,
                            p_foundation_date)
    THEN
      raise_application_error(pkg_exception.gc_publisher_already_exists,
                              'The publisher "' || p_publisher_name ||
                              '" was already exists with these parameters:' ||
                              chr(10) || 'Headquarters: ' || p_headquarters ||
                              chr(10) || 'CEO name: ' || p_ceo_first_name || ' ' ||
                              p_ceo_last_name || chr(10) ||
                              'Foundation date: ' || p_foundation_date);
    ELSE
      INSERT INTO publishers
        (publisher_name
        ,headquarters
        ,ceo_first_name
        ,ceo_last_name
        ,foundation_date)
      VALUES
        (p_publisher_name
        ,p_headquarters
        ,p_ceo_first_name
        ,p_ceo_last_name
        ,p_foundation_date);
    END IF;
  END;

  ------------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION does_publisher_exist(p_publisher_name  VARCHAR2
                               ,p_headquarters    VARCHAR2
                               ,p_ceo_first_name  VARCHAR2
                               ,p_ceo_last_name   VARCHAR2
                               ,p_foundation_date DATE) RETURN BOOLEAN IS
  
    v_temp_publisher_exists NUMBER;
  
  BEGIN
    SELECT COUNT(p.id)
      INTO v_temp_publisher_exists
      FROM publishers p
     WHERE p.publisher_name = p_publisher_name
       AND p.publisher_name = p_headquarters
       AND p.ceo_first_name = p_ceo_first_name
       AND p.ceo_last_name = p_ceo_last_name
       AND p.foundation_date = p_foundation_date;
    IF v_temp_publisher_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

  -----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION does_publisher_exist_by_name(p_publisher_name VARCHAR2)
    RETURN BOOLEAN IS
  
    v_temp_publisher_exists NUMBER;
  
  BEGIN
    SELECT COUNT(p.id)
      INTO v_temp_publisher_exists
      FROM publishers p
     WHERE p.publisher_name = p_publisher_name;
    IF v_temp_publisher_exists > 0
    THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

  -----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION id_of_publisher_by_name(p_publisher_name VARCHAR2) RETURN NUMBER IS
    
    v_temp_publisher_id number;
    
  BEGIN
   SELECT p.id
   INTO v_temp_publisher_id
   FROM publishers p
   WHERE p.publisher_name = p_publisher_name;
   RETURN v_temp_publisher_id;
  END;

END pkg_publishers;
/
