CREATE OR REPLACE FUNCTION get_medicament_status(
    p_id_medicament VARCHAR,
    p_quantite_boite NUMERIC
) RETURNS VARCHAR AS $$
DECLARE
    status_name VARCHAR(100);
BEGIN
    SELECT s.nom
    INTO status_name
    FROM medicament_status_stock mss
    JOIN status s ON mss.id_status = s.id_status
    WHERE mss.id_medicament = p_id_medicament
      AND p_quantite_boite BETWEEN mss.minimum AND mss.maximum
    LIMIT 1;

    IF NOT FOUND THEN
        RETURN '';
    END IF;

    RETURN status_name;
END;
$$ LANGUAGE plpgsql;

SELECT 
    sm.id_stock_medicament,
    sm.id_medicament,
    sm.quantite_boite,
    get_medicament_status(sm.id_medicament, sm.quantite_boite) AS status
FROM 
    stock_medicaments sm;

SELECT 
    sm.id_stock_medicament,
    sm.id_medicament,
    sm.quantite_boite,
    sm.id_unite,
    get_medicament_status(sm.id_medicament, sm.quantite_boite) AS status
FROM 
    stock_medicaments sm
WHERE sm.date_peremption > CURRENT_DATE 
GROUP BY sm.id_medicament,sm.quantite_boite,sm.id_unite
ORDER BY sm.date_peremption ASC;


SELECT 
    sm.id_medicament,
    SUM(sm.quantite_boite) AS total_quantite,
    get_medicament_status(sm.id_medicament, SUM(sm.quantite_boite)) AS status
FROM 
    stock_medicaments sm
WHERE 
    sm.date_peremption > CURRENT_DATE 
GROUP BY 
    sm.id_medicament
ORDER BY 
    MAX(sm.date_peremption) ASC;
