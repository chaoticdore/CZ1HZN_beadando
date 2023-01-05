CREATE OR REPLACE VIEW vw_publishers AS
SELECT p.id,
       p.publisher_name,
       p.headquarters,
       p.ceo_first_name,
       p.ceo_last_name,
       p.foundation_date
FROM publishers p;
