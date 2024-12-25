CREATE DATABASE pharmacie;

CREATE TABLE maladies (
   id_maladie VARCHAR(50) DEFAULT CONCAT('MAL_', nextval('seq_maladies')),
   nom VARCHAR(50) NOT NULL,
   description VARCHAR(250),
   PRIMARY KEY(id_maladie)
);

CREATE TABLE medicaments (
   id_medicament VARCHAR(50) DEFAULT CONCAT('MED_', nextval('seq_medicaments')),
   nom VARCHAR(50) NOT NULL,
   description VARCHAR(250),
   quantite_par_boite INTEGER CHECK(quantite_par_boite >= 0),
   prix_vente_boite NUMERIC(15,2) NOT NULL CHECK(prix_vente_boite >= 0),
   seuil_min_boite_en_stock INTEGER NOT NULL CHECK(seuil_min_boite_en_stock >= 0),
   PRIMARY KEY(id_medicament)
);

CREATE TABLE unites(
   id_unite VARCHAR(50) DEFAULT CONCAT('UNI', nextval('seq_unites')) ,
   nom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_unite)
);

CREATE TABLE laboratoires (
   id_laboratoire VARCHAR(50) DEFAULT CONCAT('LAB_', nextval('seq_laboratoires')),
   nom VARCHAR(50) NOT NULL,
   contact VARCHAR(50),
   adresse VARCHAR(100),
   PRIMARY KEY(id_laboratoire)
);

CREATE TABLE symptomes (
   id_symptomes VARCHAR(50) DEFAULT CONCAT('SYM_', nextval('seq_symptomes')),
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_symptomes)
);

CREATE TABLE mouvement_stock (
   id_mvt VARCHAR(50) DEFAULT CONCAT('MVT_', nextval('seq_mouvement_stock')),
   date_mouvement DATE,
   total NUMERIC(15,2) NOT NULL CHECK(total >= 0),
   PRIMARY KEY(id_mvt)
);

CREATE TABLE mouvement_stock_details (
   id_mvt_stock_detail VARCHAR(50) DEFAULT CONCAT('MSD_', nextval('seq_mouvement_stock_details')),
   entree INTEGER CHECK(entree >= 0),
   sortie INTEGER CHECK(sortie >= 0),
   prix_unitaire NUMERIC(15,2) CHECK(prix_unitaire >= 0),
   id_medicament VARCHAR(50) NOT NULL,
   id_unite VARCHAR(50)  NOT NULL,
   id_mvt VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_mvt_stock_detail),
   FOREIGN KEY(id_medicament) REFERENCES medicaments(id_medicament),
   FOREIGN KEY(id_unite) REFERENCES unites(id_unite),
   FOREIGN KEY(id_mvt) REFERENCES mouvement_stock(id_mvt)
);

CREATE TABLE achats (
   id_achat VARCHAR(50) DEFAULT CONCAT('ACH_', nextval('seq_achats')),
   date_achat DATE NOT NULL,
   total NUMERIC(15,2) CHECK(total >= 0),
   id_laboratoire VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_achat),
   FOREIGN KEY(id_laboratoire) REFERENCES laboratoires(id_laboratoire)
);

CREATE TABLE ventes (
   id_vente VARCHAR(50) DEFAULT CONCAT('VEN_', nextval('seq_ventes')),
   date_vente DATE,
   total NUMERIC(15,2) CHECK(total >= 0),
   PRIMARY KEY(id_vente)
);

CREATE TABLE achat_details (
   id_achat_details VARCHAR(50) DEFAULT CONCAT('ACD_', nextval('seq_achat_details')),
   quantite INTEGER NOT NULL,
   prix_unitaire NUMERIC(15,2) CHECK(prix_unitaire >= 0),
   id_achat VARCHAR(50) NOT NULL,
   id_medicament VARCHAR(50) NOT NULL,
   id_unite VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_achat_details),
   FOREIGN KEY(id_achat) REFERENCES achats(id_achat),
   FOREIGN KEY(id_medicament) REFERENCES medicaments(id_medicament),
   FOREIGN KEY(id_unite) REFERENCES unites(id_unite)
);

CREATE TABLE vente_details (
   id_vente_detail VARCHAR(50) DEFAULT CONCAT('VND_', nextval('seq_vente_details')),
   quantite INTEGER,
   prix_unitaire NUMERIC(15,2) CHECK(prix_unitaire >= 0),
   reduction NUMERIC(5,2),
   id_vente VARCHAR(50) NOT NULL,
   id_medicament VARCHAR(50) NOT NULL,
   id_unite VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_vente_detail),
   FOREIGN KEY(id_vente) REFERENCES ventes(id_vente),
   FOREIGN KEY(id_medicament) REFERENCES medicaments(id_medicament),
   FOREIGN KEY(id_unite) REFERENCES unites(id_unite)
);

CREATE TABLE reductions (
   id_reduction VARCHAR(50) DEFAULT CONCAT('RED_', nextval('seq_reductions')),
   pourcentage NUMERIC(5,2) NOT NULL,
   date_debut DATE NOT NULL,
   date_fin DATE NOT NULL CHECK(date_fin > date_debut),
   id_medicament VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_reduction),
   FOREIGN KEY(id_medicament) REFERENCES medicaments(id_medicament)
);


CREATE TABLE traitements(
   id_maladie VARCHAR(50) ,
   id_medicament VARCHAR(50) ,
   efficacite INTEGER,
   PRIMARY KEY(id_maladie, id_medicament),
   FOREIGN KEY(id_maladie) REFERENCES maladies(id_maladie),
   FOREIGN KEY(id_medicament) REFERENCES medicaments(id_medicament)
);

CREATE TABLE maladies_symptomes(
   id_maladie VARCHAR(50) ,
   id_symptomes VARCHAR(50) ,
   PRIMARY KEY(id_maladie, id_symptomes),
   FOREIGN KEY(id_maladie) REFERENCES maladies(id_maladie),
   FOREIGN KEY(id_symptomes) REFERENCES symptomes(id_symptomes)
);

CREATE TABLE medicament_laboratoire(
   id_medicament VARCHAR(50) ,
   id_laboratoire VARCHAR(50) ,
   prix_achat NUMERIC(15,2)  NOT NULL CHECK(prix_achat >= 0),
   minimum_achat INTEGER NOT NULL CHECK(minimum_achat >= 0),
   PRIMARY KEY(id_medicament, id_laboratoire),
   FOREIGN KEY(id_medicament) REFERENCES medicaments(id_medicament),
   FOREIGN KEY(id_laboratoire) REFERENCES laboratoires(id_laboratoire)
);

CREATE TABLE utilisateurs(
   id_utilisateur VARCHAR(50)   DEFAULT CONCAT('UTI_', nextval('seq_utilisateurs')),
   nom_complet VARCHAR(150)  NOT NULL,
   email VARCHAR(50)  NOT NULL,
   mot_de_passe VARCHAR(255)  NOT NULL,
   contact VARCHAR(30) ,
   role VARCHAR(30)  NOT NULL DEFAULT 'admin',
   PRIMARY KEY(id_utilisateur),
   UNIQUE(email)
);
