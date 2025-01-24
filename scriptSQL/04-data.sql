-- insertion admin 
INSERT INTO utilisateurs (nom_complet, email, mot_de_passe, contact, role)
VALUES (
    'Administrateur',
    'admin@email.com',
    crypt('admin', gen_salt('bf')),
    '0343886428',
    'admin'
);

INSERT INTO utilisateurs (nom_complet, email, mot_de_passe, contact, role)
VALUES (
    'vendeur 1',
    'vendeur1@email.com',
    crypt('vendeur', gen_salt('bf')),
    '0320000000',
    'vendeur'
);

INSERT INTO utilisateurs (nom_complet, email, mot_de_passe, contact, role,esthomme)
VALUES (
    'vendeur 2 femme',
    'vendeur2@email.com',
    crypt('vf', gen_salt('bf')),
    '0320000000',
    'vendeur',
    false
);

INSERT INTO utilisateurs (nom_complet, email, mot_de_passe, contact, role,esthomme)
VALUES (
    'vendeur 3 homme',
    'vendeur3@email.com',
    crypt('vh', gen_salt('bf')),
    '0320000000',
    'vendeur',
    true
);



INSERT INTO unites(id_unite,nom,id_unite_mere) VALUES('UNI_1','boite plaquette',null);
INSERT INTO unites(id_unite,nom,id_unite_mere) VALUES('UNI_2','plaquette','UNI_1');

INSERT INTO maladies (id_maladie,nom, description)VALUES ('MAL_1','Fievre','Elevation de la température corporelle au-dessus de 38°C.');
INSERT INTO maladies (id_maladie,nom, description)VALUES ('MAL_2','Arthrite','Inflammation des articulations');
INSERT INTO maladies (id_maladie,nom, description)VALUES ('MAL_3''Angine bactérienne','Infection bactérienne de la gorge');

INSERT INTO categorie(id_categorie,categorie,age_min,age_max) VALUES('CAT_1','enfant',0,12);
INSERT INTO categorie(id_categorie,categorie,age_min,age_max) VALUES('CAT_2','adulte',13,59);
INSERT INTO categorie(id_categorie,categorie,age_min,age_max) VALUES('CAT_3','personne age',60,75);

INSERT INTO type_medicament(id_type,type_medicament) VALUES('TYP_1','Injectable');
INSERT INTO type_medicament(id_type,type_medicament) VALUES('TYP_2','Consommable');



INSERT INTO medicaments (id_medicament,nom, description,id_type)VALUES ('MED_1','Paracetamol pour enfant',' medicament injectable','TYP_1');
INSERT INTO medicaments (id_medicament,nom, description,id_type)VALUES ('MED_2','Amoxicilline pour enfant','Antibiotique de la famille des beta-lactamines injectable','TYP_1');
INSERT INTO medicaments (id_medicament,nom, description,id_type)VALUES ('MED_3','Amoxicilline pour adulte','Antibiotique de la famille des beta-lactamines consomable','TYP_2');


INSERT INTO traitements (id_maladie, id_medicament, id_categorie, efficacite) VALUES
('MAL_1', 'MED_1', 'CAT_1', 65),
('MAL_1', 'MED_2', 'CAT_1', 70),
('MAL_1', 'MED_3', 'CAT_2', 75),

('MAL_2', 'MED_1', 'CAT_1', 60),
('MAL_2', 'MED_2', 'CAT_1', 70),
('MAL_2', 'MED_3', 'CAT_2', 80),

('MAL_3', 'MED_1', 'CAT_1', 50),
('MAL_3', 'MED_2', 'CAT_1', 55),
('MAL_3', 'MED_3', 'CAT_2', 85);


INSERT INTO status(id_status,nom) VALUES('STA_1','suffisant');
INSERT INTO status(id_status,nom) VALUES('STA_2','critique');
INSERT INTO status(id_status,nom) VALUES('STA_3','rupture');

-- Insertion des stocks pour MED_1
INSERT INTO medicament_status_stock (id_medicament, id_status, minimum, maximum) VALUES
('MED_1', 'STA_1', 50, 200), -- Stock suffisant
('MED_1', 'STA_2', 10, 49),  -- Stock critique
('MED_1', 'STA_3', 0, 9);    -- Rupture de stock

-- Insertion des stocks pour MED_2
INSERT INTO medicament_status_stock (id_medicament, id_status, minimum, maximum) VALUES
('MED_2', 'STA_1', 100, 500), -- Stock suffisant
('MED_2', 'STA_2', 20, 99),   -- Stock critique
('MED_2', 'STA_3', 0, 19);    -- Rupture de stock

-- Insertion des stocks pour MED_3
INSERT INTO medicament_status_stock (id_medicament, id_status, minimum, maximum) VALUES
('MED_3', 'STA_1', 200, 1000), -- Stock suffisant
('MED_3', 'STA_2', 50, 199),   -- Stock critique
('MED_3', 'STA_3', 0, 49);     -- Rupture de stock


-- Insertion des conversions pour MED_1
INSERT INTO conversion (id_medicament, id_unite_mere, quantite) VALUES
('MED_1', 'UNI_1', 20); -- Par exemple : 1 boîte contient 20 unités (plaquettes)

-- Insertion des conversions pour MED_2
INSERT INTO conversion (id_medicament, id_unite_mere, quantite) VALUES
('MED_2', 'UNI_1', 10); -- Par exemple : 1 boîte contient 10 unités (plaquettes)

-- Insertion des conversions pour MED_3
INSERT INTO conversion (id_medicament, id_unite_mere, quantite) VALUES
('MED_3', 'UNI_1', 15); -- Par exemple : 1 boîte contient 15 unités (plaquettes)



-- Prix pour le médicament MED_1
INSERT INTO prix_medicaments (id_prix_medicament, prix_vente_unitaire, id_unite, id_medicament) VALUES
('PRM_1', 20000.00, 'UNI_1', 'MED_1'), -- Prix pour une boîte (boîte plaquette)
('PRM_2', 1500.00, 'UNI_2', 'MED_1'); -- Prix pour une plaquette

-- Prix pour le médicament MED_2
INSERT INTO prix_medicaments (id_prix_medicament, prix_vente_unitaire, id_unite, id_medicament) VALUES
('PRM_3', 40000.00, 'UNI_1', 'MED_2'), -- Prix pour une boîte (boîte plaquette)
('PRM_4', 3500.00, 'UNI_2', 'MED_2'); -- Prix pour une plaquette

-- Prix pour le médicament MED_3
INSERT INTO prix_medicaments (id_prix_medicament, prix_vente_unitaire, id_unite, id_medicament) VALUES
('PRM_5', 60000.00, 'UNI_1', 'MED_3'), -- Prix pour une boîte (boîte plaquette)
('PRM_6', 5000.00, 'UNI_2', 'MED_3'); -- Prix pour une plaquette



-- Insérer des données dans la table recommandation
INSERT INTO recommandation (id_recommandation, date_debut, date_fin, id_medicament) 
VALUES 
    ('REC_1', '2025-01-01', '2025-02-26', 'MED_1'),
    ('REC_2', '2025-02-01', '2025-07-27', 'MED_2'),
    ('REC_3', '2025-03-01', '2025-08-28', 'MED_3');






-- Symptômes pour la Fièvre
INSERT INTO symptomes (nom) VALUES ('Température élevée');
INSERT INTO symptomes (nom) VALUES ('Frissons');

-- Symptômes pour l'Arthrite
INSERT INTO symptomes (nom) VALUES ('Douleurs articulaires');
INSERT INTO symptomes (nom) VALUES ('Raideur matinale');

-- Symptômes pour l'Angine bactérienne
INSERT INTO symptomes (nom) VALUES ('Mal de gorge intense');
INSERT INTO symptomes (nom) VALUES ('Difficultés à avaler');

INSERT INTO categorie (categorie, age_max)VALUES ('Bébé',3);
INSERT INTO categorie (categorie, age_max)VALUES ('Enfant',12);
INSERT INTO categorie (categorie, age_max)VALUES ('Adulte',60);

SELECT * FROM utilisateurs
WHERE email = 'admin@email.com'
  AND mot_de_passe = crypt('admin', mot_de_passe);


-- Insertion des traitements
INSERT INTO traitements (id_maladie, id_medicament, id_categorie, efficacite) VALUES
  ('MAL_1', 'MED_2', 'CAT_1', 70), 
  ('MAL_1', 'MED_2', 'CAT_2', 70),
  ('MAL_2', 'MED_3', 'CAT_1', 50), 
  ('MAL_2', 'MED_3', 'CAT_2', 70),  
  ('MAL_4', 'MED_1', 'CAT_2', 40);

INSERT INTO traitements (id_maladie, id_medicament, id_categorie, efficacite) VALUES
  ('MAL_6', 'MED_4', 'CAT_1', 70),  
  ('MAL_6', 'MED_5', 'CAT_2', 70);
  
INSERT INTO type_medicament (type_medicament)VALUES ('Injectable');
INSERT INTO type_medicament (type_medicament)VALUES ('Consommable');


select vd.id_vente from vente_details vd join medicaments m on vd.id_medicament = m.id_medicament
join traitements t on t.id_medicament = m.id_medicament WHERE t.id_categorie='CAT_1' AND m.id_type='TYP_1';

INSERT INTO status (nom) VALUES 
('Rupture de stock'),
('Stock critique'),
('Stock suffisant');

ALTER TABLE ventes
ADD COLUMN id_utilisateur VARCHAR(50) NOT NULL, -- Valeur par défaut (administrateur)
ADD COLUMN commission_vendeur NUMERIC(15,2) DEFAULT 0 CHECK(commission_vendeur >= 0);


INSERT INTO commission (pourcentage, date_debut, date_fin)
VALUES 
(10, '2025-01-01', '2025-12-31'); 