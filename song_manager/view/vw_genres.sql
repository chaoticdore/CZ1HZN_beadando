CREATE OR REPLACE VIEW vw_genres AS
SELECT g.id,
       g.genre_name
FROM genres g;
