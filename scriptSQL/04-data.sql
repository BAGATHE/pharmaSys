-- insertion admin 
INSERT INTO utilisateurs (nom_complet, email, mot_de_passe, contact, role)
VALUES (
    'Administrateur',
    'admin@email.com',
    crypt('admin', gen_salt('bf')),
    '0343886428',
    'admin'
);




INSERT INTO medicaments (nom, description)VALUES ('Paracetamol','Antalgique et antipyretique');
INSERT INTO medicaments (nom, description)VALUES ('Ibuprofene','Anti-inflammatoire non steroidien');
INSERT INTO medicaments (nom, description)VALUES ('Amoxicilline','Antibiotique de la famille des beta-lactamines');
INSERT INTO categorie (categorie,age_max) VALUES ('Enfant',12);
INSERT INTO categorie (categorie,age_max) VALUES ('Adulte',60);


INSERT INTO maladies (nom, description)VALUES ('Fievre','Elevation de la température corporelle au-dessus de 38°C.');
INSERT INTO maladies (nom, description)VALUES ('Arthrite','Inflammation des articulations');
INSERT INTO maladies (nom, description)VALUES ('Angine bactérienne','Infection bactérienne de la gorge');

-- Symptômes pour la Fièvre
INSERT INTO symptomes (nom) VALUES ('Température élevée');
INSERT INTO symptomes (nom) VALUES ('Frissons');

-- Symptômes pour l'Arthrite
INSERT INTO symptomes (nom) VALUES ('Douleurs articulaires');
INSERT INTO symptomes (nom) VALUES ('Raideur matinale');

-- Symptômes pour l'Angine bactérienne
INSERT INTO symptomes (nom) VALUES ('Mal de gorge intense');
INSERT INTO symptomes (nom) VALUES ('Difficultés à avaler');



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
  

