-- insertion admin 
INSERT INTO utilisateurs (nom_complet, email, mot_de_passe, contact, role)
VALUES (
    'Administrateur',
    'admin@email.com',
    crypt('admin', gen_salt('bf')),
    '0343886428',
    'admin'
);

SELECT * FROM utilisateurs
WHERE email = 'admin@email.com'
  AND mot_de_passe = crypt('admin', mot_de_passe);
