CREATE OR REPLACE VIEW vw_artists AS
SELECT a.id,
       a.first_name,
       a.last_name,
       a.birth_place,
       a.birth_date
FROM artists a;
