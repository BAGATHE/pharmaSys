CREATE OR REPLACE VIEW v_prix_medicaments AS
SELECT 
    pm.id_prix_medicament,
    pm.prix_vente_unitaire,
    pm.id_unite,
    u.nom AS nom_unite,
    u.id_unite_mere,
    pm.id_medicament,
    m.nom AS nom_medicament,
    m.description AS description_medicament
FROM 
    prix_medicaments pm
JOIN 
    medicaments m ON pm.id_medicament = m.id_medicament
JOIN 
    unites u ON pm.id_unite = u.id_unite;





CREATE VIEW unites_avec_parents AS
SELECT 
    u.id_unite,
    u.nom AS nom_unite,
    um.id_unite AS id_unite_mere,
    um.nom AS nom_unite_mere
FROM 
    unites u
LEFT JOIN 
    unites um
ON 
    u.id_unite_mere = um.id_unite;




CREATE OR REPLACE VIEW v_medicament_conversion AS
SELECT 
    m.id_medicament, 
    m.nom AS medicament_nom, 
    m.description AS medicament_description,
    c.id_unite_mere,
    um.nom AS unite_mere_nom, 
    u.id_unite AS id_unite_enfant, 
    u.nom AS unite_enfant_nom, 
    c.quantite
FROM 
    medicaments m
JOIN 
    conversion c ON m.id_medicament = c.id_medicament
JOIN 
    unites um ON c.id_unite_mere = um.id_unite
LEFT JOIN 
    unites u ON um.id_unite = u.id_unite_mere;

CREATE VIEW medicament_details AS
SELECT 
    ml.id_medicament,
    m.nom AS nom_medicament,
    m.description AS description_medicament,
    ml.id_laboratoire,
    l.nom AS nom_laboratoire,
    l.contact AS contact_laboratoire,
    l.adresse AS adresse_laboratoire,
    ml.id_unite,
    u.nom AS nom_unite,
    ml.prix_achat,
    ml.minimum_achat
FROM 
    medicament_laboratoire ml
INNER JOIN 
    medicaments m ON ml.id_medicament = m.id_medicament
INNER JOIN 
    laboratoires l ON ml.id_laboratoire = l.id_laboratoire
INNER JOIN 
    unites u ON ml.id_unite = u.id_unite;




WITH RECURSIVE unites_liees AS (
    -- Unités directement liées au médicament dans conversion
    SELECT u.id_unite, u.nom, u.id_unite_mere, c.quantite, 1 as niveau
    FROM conversion c
    JOIN unites u ON c.id_unite_mere = u.id_unite
    WHERE c.id_medicament = 'MED_2'

    UNION ALL

    -- Unités enfants
    SELECT u.id_unite, u.nom, u.id_unite_mere, ul.quantite, ul.niveau + 1
    FROM unites u
    JOIN unites_liees ul ON u.id_unite_mere = ul.id_unite
)
SELECT DISTINCT * FROM unites_liees
ORDER BY niveau, nom;