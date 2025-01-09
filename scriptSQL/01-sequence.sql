-- Active: 1735576927584@@127.0.0.1@5432@pharmacie
-- Séquences pour les tables
CREATE SEQUENCE seq_maladies  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_medicaments  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_laboratoires  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_symptomes  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_mouvement_stock  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_mouvement_stock_details  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_achats  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ventes  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_achat_details  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_vente_details  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reductions  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_unites  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_stock_medicament  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_prix_medicament  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_utilisateurs  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_categorie  START WITH 1 INCREMENT BY 1;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
