--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: get_medicament_status(character varying, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_medicament_status(p_id_medicament character varying, p_quantite_boite numeric) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.get_medicament_status(p_id_medicament character varying, p_quantite_boite numeric) OWNER TO postgres;

--
-- Name: update_total_achat(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_total_achat() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   UPDATE achats
   SET total = (
      SELECT COALESCE(SUM(quantite * prix_unitaire), 0)
      FROM achat_details
      WHERE id_achat = NEW.id_achat
   )
   WHERE id_achat = NEW.id_achat;

   RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_total_achat() OWNER TO postgres;

--
-- Name: update_total_vente(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_total_vente() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   UPDATE ventes
   SET total = (
      SELECT COALESCE(SUM(quantite * prix_unitaire * (1 - COALESCE(reduction, 0) / 100)), 0)
      FROM vente_details
      WHERE id_vente = NEW.id_vente
   )
   WHERE id_vente = NEW.id_vente;

   RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_total_vente() OWNER TO postgres;

--
-- Name: seq_achat_details; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_achat_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_achat_details OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: achat_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achat_details (
    id_achat_details character varying(50) DEFAULT concat('ACD_', nextval('public.seq_achat_details'::regclass)) NOT NULL,
    quantite integer NOT NULL,
    prix_unitaire numeric(15,2),
    id_achat character varying(50) NOT NULL,
    id_medicament character varying(50) NOT NULL,
    id_unite character varying(50) NOT NULL,
    CONSTRAINT achat_details_prix_unitaire_check CHECK ((prix_unitaire >= (0)::numeric))
);


ALTER TABLE public.achat_details OWNER TO postgres;

--
-- Name: seq_achats; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_achats
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_achats OWNER TO postgres;

--
-- Name: achats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achats (
    id_achat character varying(50) DEFAULT concat('ACH_', nextval('public.seq_achats'::regclass)) NOT NULL,
    date_achat date NOT NULL,
    total numeric(15,2),
    id_laboratoire character varying(50) NOT NULL,
    CONSTRAINT achats_total_check CHECK ((total >= (0)::numeric))
);


ALTER TABLE public.achats OWNER TO postgres;

--
-- Name: seq_categorie; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categorie
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categorie OWNER TO postgres;

--
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorie (
    id_categorie character varying(50) DEFAULT concat('CAT_', nextval('public.seq_categorie'::regclass)) NOT NULL,
    categorie character varying(240) NOT NULL,
    age_max integer
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- Name: conversion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversion (
    id_medicament character varying(50) NOT NULL,
    id_unite_mere character varying(50) NOT NULL,
    quantite integer
);


ALTER TABLE public.conversion OWNER TO postgres;

--
-- Name: seq_laboratoires; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_laboratoires
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_laboratoires OWNER TO postgres;

--
-- Name: laboratoires; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laboratoires (
    id_laboratoire character varying(50) DEFAULT concat('LAB_', nextval('public.seq_laboratoires'::regclass)) NOT NULL,
    nom character varying(50) NOT NULL,
    contact character varying(50),
    adresse character varying(100)
);


ALTER TABLE public.laboratoires OWNER TO postgres;

--
-- Name: seq_maladies; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_maladies
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_maladies OWNER TO postgres;

--
-- Name: maladies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maladies (
    id_maladie character varying(50) DEFAULT concat('MAL_', nextval('public.seq_maladies'::regclass)) NOT NULL,
    nom character varying(50) NOT NULL,
    description character varying(250)
);


ALTER TABLE public.maladies OWNER TO postgres;

--
-- Name: maladies_symptomes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maladies_symptomes (
    id_maladie character varying(50) NOT NULL,
    id_symptomes character varying(50) NOT NULL
);


ALTER TABLE public.maladies_symptomes OWNER TO postgres;

--
-- Name: medicament_laboratoire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicament_laboratoire (
    id_medicament character varying(50) NOT NULL,
    id_laboratoire character varying(50) NOT NULL,
    id_unite character varying(50) NOT NULL,
    prix_achat numeric(15,2) NOT NULL,
    minimum_achat integer NOT NULL,
    CONSTRAINT medicament_laboratoire_minimum_achat_check CHECK ((minimum_achat >= 0)),
    CONSTRAINT medicament_laboratoire_prix_achat_check CHECK ((prix_achat >= (0)::numeric))
);


ALTER TABLE public.medicament_laboratoire OWNER TO postgres;

--
-- Name: seq_medicaments; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_medicaments
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_medicaments OWNER TO postgres;

--
-- Name: medicaments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicaments (
    id_medicament character varying(50) DEFAULT concat('MED_', nextval('public.seq_medicaments'::regclass)) NOT NULL,
    nom character varying(50) NOT NULL,
    description character varying(250),
    id_type character varying(10) NOT NULL
);


ALTER TABLE public.medicaments OWNER TO postgres;

--
-- Name: seq_unites; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_unites
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_unites OWNER TO postgres;

--
-- Name: unites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unites (
    id_unite character varying(50) DEFAULT concat('UNI_', nextval('public.seq_unites'::regclass)) NOT NULL,
    nom character varying(50) NOT NULL,
    id_unite_mere character varying(50)
);


ALTER TABLE public.unites OWNER TO postgres;

--
-- Name: medicament_details; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.medicament_details AS
 SELECT ml.id_medicament,
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
   FROM (((public.medicament_laboratoire ml
     JOIN public.medicaments m ON (((ml.id_medicament)::text = (m.id_medicament)::text)))
     JOIN public.laboratoires l ON (((ml.id_laboratoire)::text = (l.id_laboratoire)::text)))
     JOIN public.unites u ON (((ml.id_unite)::text = (u.id_unite)::text)));


ALTER TABLE public.medicament_details OWNER TO postgres;

--
-- Name: medicament_status_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicament_status_stock (
    id_medicament character varying(50) NOT NULL,
    id_status character varying(50) NOT NULL,
    minimum integer,
    maximum integer,
    CONSTRAINT chk_min_le_max CHECK ((minimum <= maximum))
);


ALTER TABLE public.medicament_status_stock OWNER TO postgres;

--
-- Name: seq_mouvement_stock; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_mouvement_stock
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_mouvement_stock OWNER TO postgres;

--
-- Name: mouvement_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mouvement_stock (
    id_mvt character varying(50) DEFAULT concat('MVT_', nextval('public.seq_mouvement_stock'::regclass)) NOT NULL,
    date_mouvement date
);


ALTER TABLE public.mouvement_stock OWNER TO postgres;

--
-- Name: seq_mouvement_stock_details; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_mouvement_stock_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_mouvement_stock_details OWNER TO postgres;

--
-- Name: mouvement_stock_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mouvement_stock_details (
    id_mvt_stock_detail character varying(50) DEFAULT concat('MSD_', nextval('public.seq_mouvement_stock_details'::regclass)) NOT NULL,
    entree numeric(7,2),
    sortie numeric(7,2),
    prix_unitaire numeric(15,2),
    id_medicament character varying(50) NOT NULL,
    id_unite character varying(50) NOT NULL,
    id_mvt character varying(50) NOT NULL,
    CONSTRAINT mouvement_stock_details_entree_check CHECK ((entree >= (0)::numeric)),
    CONSTRAINT mouvement_stock_details_prix_unitaire_check CHECK ((prix_unitaire >= (0)::numeric)),
    CONSTRAINT mouvement_stock_details_sortie_check CHECK ((sortie >= (0)::numeric))
);


ALTER TABLE public.mouvement_stock_details OWNER TO postgres;

--
-- Name: seq_prix_medicament; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_prix_medicament
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_prix_medicament OWNER TO postgres;

--
-- Name: prix_medicaments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prix_medicaments (
    id_prix_medicament character varying(50) DEFAULT concat('PRM_', nextval('public.seq_prix_medicament'::regclass)) NOT NULL,
    prix_vente_unitaire numeric(15,2),
    id_unite character varying(50) NOT NULL,
    id_medicament character varying(50) NOT NULL
);


ALTER TABLE public.prix_medicaments OWNER TO postgres;

--
-- Name: seq_reductions; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_reductions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_reductions OWNER TO postgres;

--
-- Name: reductions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reductions (
    id_reduction character varying(50) DEFAULT concat('RED_', nextval('public.seq_reductions'::regclass)) NOT NULL,
    pourcentage numeric(5,2) NOT NULL,
    date_debut date NOT NULL,
    date_fin date NOT NULL,
    id_medicament character varying(50) NOT NULL,
    CONSTRAINT reductions_check CHECK ((date_fin > date_debut))
);


ALTER TABLE public.reductions OWNER TO postgres;

--
-- Name: seq_status; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_status
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status OWNER TO postgres;

--
-- Name: seq_stock_medicament; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_stock_medicament
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_stock_medicament OWNER TO postgres;

--
-- Name: seq_symptomes; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_symptomes
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_symptomes OWNER TO postgres;

--
-- Name: seq_types; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_types
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_types OWNER TO postgres;

--
-- Name: seq_utilisateurs; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_utilisateurs
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_utilisateurs OWNER TO postgres;

--
-- Name: seq_vente_details; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_vente_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vente_details OWNER TO postgres;

--
-- Name: seq_ventes; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_ventes
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_ventes OWNER TO postgres;

--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id_status character varying(50) DEFAULT concat('STA', nextval('public.seq_status'::regclass)) NOT NULL,
    nom character varying(100) NOT NULL
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: stock_medicaments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_medicaments (
    id_stock_medicament character varying(50) DEFAULT concat('STM_', nextval('public.seq_stock_medicament'::regclass)) NOT NULL,
    date_peremption date NOT NULL,
    quantite_boite numeric(10,2) NOT NULL,
    id_unite character varying(50) NOT NULL,
    id_laboratoire character varying(50) NOT NULL,
    id_medicament character varying(50) NOT NULL
);


ALTER TABLE public.stock_medicaments OWNER TO postgres;

--
-- Name: symptomes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.symptomes (
    id_symptomes character varying(50) DEFAULT concat('SYM_', nextval('public.seq_symptomes'::regclass)) NOT NULL,
    nom character varying(50) NOT NULL
);


ALTER TABLE public.symptomes OWNER TO postgres;

--
-- Name: traitements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traitements (
    id_maladie character varying(50) NOT NULL,
    id_medicament character varying(50) NOT NULL,
    id_categorie character varying(50) NOT NULL,
    efficacite integer
);


ALTER TABLE public.traitements OWNER TO postgres;

--
-- Name: type_medicament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_medicament (
    id_type character varying(50) DEFAULT concat('TYP_', nextval('public.seq_types'::regclass)) NOT NULL,
    type_medicament character varying(50) NOT NULL
);


ALTER TABLE public.type_medicament OWNER TO postgres;

--
-- Name: unites_avec_parents; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.unites_avec_parents AS
 SELECT u.id_unite,
    u.nom AS nom_unite,
    um.id_unite AS id_unite_mere,
    um.nom AS nom_unite_mere
   FROM (public.unites u
     LEFT JOIN public.unites um ON (((u.id_unite_mere)::text = (um.id_unite)::text)));


ALTER TABLE public.unites_avec_parents OWNER TO postgres;

--
-- Name: utilisateurs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateurs (
    id_utilisateur character varying(50) DEFAULT concat('UTI_', nextval('public.seq_utilisateurs'::regclass)) NOT NULL,
    nom_complet character varying(150) NOT NULL,
    email character varying(50) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    contact character varying(30),
    role character varying(30) DEFAULT 'admin'::character varying NOT NULL
);


ALTER TABLE public.utilisateurs OWNER TO postgres;

--
-- Name: v_medicament_conversion; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_medicament_conversion AS
 SELECT m.id_medicament,
    m.nom AS medicament_nom,
    m.description AS medicament_description,
    c.id_unite_mere,
    um.nom AS unite_mere_nom,
    u.id_unite AS id_unite_enfant,
    u.nom AS unite_enfant_nom,
    c.quantite
   FROM (((public.medicaments m
     JOIN public.conversion c ON (((m.id_medicament)::text = (c.id_medicament)::text)))
     JOIN public.unites um ON (((c.id_unite_mere)::text = (um.id_unite)::text)))
     LEFT JOIN public.unites u ON (((um.id_unite)::text = (u.id_unite_mere)::text)));


ALTER TABLE public.v_medicament_conversion OWNER TO postgres;

--
-- Name: v_prix_medicaments; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_prix_medicaments AS
 SELECT pm.id_prix_medicament,
    pm.prix_vente_unitaire,
    pm.id_unite,
    u.nom AS nom_unite,
    u.id_unite_mere,
    pm.id_medicament,
    m.nom AS nom_medicament,
    m.description AS description_medicament
   FROM ((public.prix_medicaments pm
     JOIN public.medicaments m ON (((pm.id_medicament)::text = (m.id_medicament)::text)))
     JOIN public.unites u ON (((pm.id_unite)::text = (u.id_unite)::text)));


ALTER TABLE public.v_prix_medicaments OWNER TO postgres;

--
-- Name: vente_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vente_details (
    id_vente_detail character varying(50) DEFAULT concat('VND_', nextval('public.seq_vente_details'::regclass)) NOT NULL,
    quantite integer,
    prix_unitaire numeric(15,2),
    reduction numeric(5,2),
    id_vente character varying(50) NOT NULL,
    id_medicament character varying(50) NOT NULL,
    id_unite character varying(50) NOT NULL,
    CONSTRAINT vente_details_prix_unitaire_check CHECK ((prix_unitaire >= (0)::numeric))
);


ALTER TABLE public.vente_details OWNER TO postgres;

--
-- Name: ventes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventes (
    id_vente character varying(50) DEFAULT concat('VEN_', nextval('public.seq_ventes'::regclass)) NOT NULL,
    date_vente date,
    total numeric(15,2),
    CONSTRAINT ventes_total_check CHECK ((total >= (0)::numeric))
);


ALTER TABLE public.ventes OWNER TO postgres;

--
-- Data for Name: achat_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achat_details (id_achat_details, quantite, prix_unitaire, id_achat, id_medicament, id_unite) FROM stdin;
ACD_1	100	20000.00	ACH_1	MED_1	UNI_1
ACD_2	200	30000.00	ACH_1	MED_4	UNI_1
ACD_3	100	20000.00	ACH_2	MED_5	UNI_1
ACD_4	100	20000.00	ACH_2	MED_6	UNI_1
ACD_5	25	15000.00	ACH_3	MED_1	UNI_1
ACD_6	25	15000.00	ACH_4	MED_1	UNI_1
ACD_7	10	20000.00	ACH_5	MED_1	UNI_1
ACD_8	6	20000.00	ACH_6	MED_1	UNI_1
\.


--
-- Data for Name: achats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achats (id_achat, date_achat, total, id_laboratoire) FROM stdin;
ACH_1	2025-01-09	8000000.00	LAB_1
ACH_2	2025-01-09	4000000.00	LAB_1
ACH_3	2025-01-22	375000.00	LAB_2
ACH_4	2025-01-10	375000.00	LAB_2
ACH_5	2025-01-13	200000.00	LAB_1
ACH_6	2025-01-13	120000.00	LAB_1
\.


--
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorie (id_categorie, categorie, age_max) FROM stdin;
CAT_1	B‚b‚	3
CAT_2	Enfant	12
CAT_3	Adulte	60
\.


--
-- Data for Name: conversion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversion (id_medicament, id_unite_mere, quantite) FROM stdin;
MED_1	UNI_1	10
MED_4	UNI_1	10
MED_5	UNI_1	10
MED_6	UNI_1	10
\.


--
-- Data for Name: laboratoires; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laboratoires (id_laboratoire, nom, contact, adresse) FROM stdin;
LAB_1	clandestin lab	clandestin@gmail.com	               sdgsgd                     
LAB_2	mada lab	mada@gmail.com	         mada                           
\.


--
-- Data for Name: maladies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maladies (id_maladie, nom, description) FROM stdin;
MAL_1	Maux de tête	                                    
MAL_2	pneumonie	maladie respiratoire      
\.


--
-- Data for Name: maladies_symptomes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maladies_symptomes (id_maladie, id_symptomes) FROM stdin;
\.


--
-- Data for Name: medicament_laboratoire; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicament_laboratoire (id_medicament, id_laboratoire, id_unite, prix_achat, minimum_achat) FROM stdin;
MED_1	LAB_1	UNI_1	20000.00	5
MED_4	LAB_1	UNI_1	30000.00	10
MED_5	LAB_1	UNI_1	20000.00	5
MED_6	LAB_1	UNI_1	20000.00	5
MED_1	LAB_2	UNI_1	15000.00	10
\.


--
-- Data for Name: medicament_status_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicament_status_stock (id_medicament, id_status, minimum, maximum) FROM stdin;
MED_1	STA1	0	0
MED_1	STA2	1	30
MED_1	STA3	31	1000
\.


--
-- Data for Name: medicaments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicaments (id_medicament, nom, description, id_type) FROM stdin;
MED_1	Ammoxicilline	                                    	TYP_2
MED_2	paracetamol	                                    	TYP_2
MED_4	Ammoxicilline beta	                                    	TYP_1
MED_5	ampicilinne pour bebe	medicament injectable uniquement                                  	TYP_1
MED_6	ampicilinne pour adulte	medicament consomable                                    	TYP_2
\.


--
-- Data for Name: mouvement_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mouvement_stock (id_mvt, date_mouvement) FROM stdin;
MVT_1	2025-01-09
MVT_2	2025-01-10
MVT_3	2025-01-11
MVT_4	2025-01-09
MVT_5	2025-01-13
MVT_6	2025-01-14
MVT_7	2025-01-22
MVT_8	2025-01-10
MVT_9	2025-01-13
MVT_10	2025-01-15
MVT_11	2025-01-16
MVT_12	2025-01-13
MVT_13	2025-01-17
MVT_14	2025-01-18
MVT_15	2025-01-19
\.


--
-- Data for Name: mouvement_stock_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mouvement_stock_details (id_mvt_stock_detail, entree, sortie, prix_unitaire, id_medicament, id_unite, id_mvt) FROM stdin;
MSD_1	100.00	0.00	20000.00	MED_1	UNI_1	MVT_1
MSD_2	200.00	0.00	30000.00	MED_4	UNI_1	MVT_1
MSD_3	0.00	10.00	4000.00	MED_1	UNI_2	MVT_2
MSD_4	0.00	5.00	5000.00	MED_4	UNI_2	MVT_2
MSD_5	0.00	5.00	5000.00	MED_4	UNI_2	MVT_3
MSD_6	100.00	0.00	20000.00	MED_5	UNI_1	MVT_4
MSD_7	100.00	0.00	20000.00	MED_6	UNI_1	MVT_4
MSD_8	0.00	70.00	40000.00	MED_1	UNI_1	MVT_5
MSD_9	0.00	29.00	40000.00	MED_1	UNI_1	MVT_6
MSD_10	25.00	0.00	15000.00	MED_1	UNI_1	MVT_7
MSD_11	25.00	0.00	15000.00	MED_1	UNI_1	MVT_8
MSD_12	10.00	0.00	20000.00	MED_1	UNI_1	MVT_9
MSD_13	0.00	5.00	4000.00	MED_1	UNI_2	MVT_10
MSD_14	0.00	3.00	50000.00	MED_4	UNI_1	MVT_10
MSD_15	0.00	1.00	40000.00	MED_1	UNI_1	MVT_11
MSD_16	6.00	0.00	20000.00	MED_1	UNI_1	MVT_12
MSD_17	0.00	1.00	40000.00	MED_1	UNI_1	MVT_13
MSD_18	0.00	15.00	40000.00	MED_1	UNI_1	MVT_14
MSD_19	0.00	5.00	4000.00	MED_1	UNI_2	MVT_15
\.


--
-- Data for Name: prix_medicaments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prix_medicaments (id_prix_medicament, prix_vente_unitaire, id_unite, id_medicament) FROM stdin;
PRM_1	40000.00	UNI_1	MED_1
PRM_2	4000.00	UNI_2	MED_1
PRM_3	50000.00	UNI_1	MED_4
PRM_4	5000.00	UNI_2	MED_4
PRM_5	30000.00	UNI_1	MED_5
PRM_6	4000.00	UNI_2	MED_5
PRM_7	40000.00	UNI_1	MED_6
PRM_8	4000.00	UNI_2	MED_6
\.


--
-- Data for Name: reductions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reductions (id_reduction, pourcentage, date_debut, date_fin, id_medicament) FROM stdin;
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id_status, nom) FROM stdin;
STA1	Rupture de stock
STA2	Stock critique
STA3	Stock suffisant
\.


--
-- Data for Name: stock_medicaments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_medicaments (id_stock_medicament, date_peremption, quantite_boite, id_unite, id_laboratoire, id_medicament) FROM stdin;
STM_5	2025-01-10	25.00	UNI_1	LAB_2	MED_1
STM_8	2026-05-12	5.50	UNI_1	LAB_1	MED_1
STM_7	2026-09-12	10.00	UNI_1	LAB_1	MED_1
STM_2	2027-05-09	199.00	UNI_1	LAB_1	MED_4
STM_4	2027-09-09	100.00	UNI_1	LAB_1	MED_6
STM_6	2027-09-12	25.00	UNI_1	LAB_2	MED_1
STM_3	2028-05-09	100.00	UNI_1	LAB_1	MED_5
STM_1	2029-05-09	0.00	UNI_1	LAB_1	MED_1
\.


--
-- Data for Name: symptomes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.symptomes (id_symptomes, nom) FROM stdin;
\.


--
-- Data for Name: traitements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.traitements (id_maladie, id_medicament, id_categorie, efficacite) FROM stdin;
MAL_1	MED_4	CAT_1	5
MAL_2	MED_5	CAT_1	70
MAL_2	MED_6	CAT_3	80
MAL_1	MED_1	CAT_3	10
\.


--
-- Data for Name: type_medicament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_medicament (id_type, type_medicament) FROM stdin;
TYP_1	Injectable
TYP_2	Consommable
\.


--
-- Data for Name: unites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unites (id_unite, nom, id_unite_mere) FROM stdin;
UNI_1	boite Unite	\N
UNI_2	unite	UNI_1
\.


--
-- Data for Name: utilisateurs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateurs (id_utilisateur, nom_complet, email, mot_de_passe, contact, role) FROM stdin;
UTI_1	Administrateur	admin@email.com	$2a$06$Xn5C.M6PY6sgkrh6cWVljeN1PTho.QrcAcf0uCibMJn7e8cm1GJGi	0343886428	admin
\.


--
-- Data for Name: vente_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vente_details (id_vente_detail, quantite, prix_unitaire, reduction, id_vente, id_medicament, id_unite) FROM stdin;
VND_1	10	4000.00	0.00	VEN_1	MED_1	UNI_2
VND_2	5	5000.00	0.00	VEN_1	MED_4	UNI_2
VND_3	5	5000.00	0.00	VEN_2	MED_4	UNI_2
VND_4	70	40000.00	0.00	VEN_3	MED_1	UNI_1
VND_5	29	40000.00	0.00	VEN_4	MED_1	UNI_1
VND_6	5	4000.00	0.00	VEN_5	MED_1	UNI_2
VND_7	3	50000.00	0.00	VEN_5	MED_4	UNI_1
VND_8	1	40000.00	0.00	VEN_6	MED_1	UNI_1
VND_9	1	40000.00	0.00	VEN_7	MED_1	UNI_1
VND_10	15	40000.00	0.00	VEN_8	MED_1	UNI_1
VND_11	5	4000.00	0.00	VEN_9	MED_1	UNI_2
\.


--
-- Data for Name: ventes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventes (id_vente, date_vente, total) FROM stdin;
VEN_1	2025-01-10	65000.00
VEN_2	2025-01-11	25000.00
VEN_3	2025-01-13	2800000.00
VEN_4	2025-01-14	1160000.00
VEN_5	2025-01-15	170000.00
VEN_6	2025-01-16	40000.00
VEN_7	2025-01-17	40000.00
VEN_8	2025-01-18	600000.00
VEN_9	2025-01-19	20000.00
\.


--
-- Name: seq_achat_details; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_achat_details', 8, true);


--
-- Name: seq_achats; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_achats', 6, true);


--
-- Name: seq_categorie; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categorie', 3, true);


--
-- Name: seq_laboratoires; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_laboratoires', 2, true);


--
-- Name: seq_maladies; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_maladies', 2, true);


--
-- Name: seq_medicaments; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_medicaments', 6, true);


--
-- Name: seq_mouvement_stock; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_mouvement_stock', 15, true);


--
-- Name: seq_mouvement_stock_details; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_mouvement_stock_details', 19, true);


--
-- Name: seq_prix_medicament; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_prix_medicament', 8, true);


--
-- Name: seq_reductions; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_reductions', 1, false);


--
-- Name: seq_status; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_status', 3, true);


--
-- Name: seq_stock_medicament; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_stock_medicament', 8, true);


--
-- Name: seq_symptomes; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_symptomes', 1, false);


--
-- Name: seq_types; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_types', 2, true);


--
-- Name: seq_unites; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_unites', 2, true);


--
-- Name: seq_utilisateurs; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_utilisateurs', 1, true);


--
-- Name: seq_vente_details; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_vente_details', 11, true);


--
-- Name: seq_ventes; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_ventes', 9, true);


--
-- Name: achat_details achat_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achat_details
    ADD CONSTRAINT achat_details_pkey PRIMARY KEY (id_achat_details);


--
-- Name: achats achats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achats
    ADD CONSTRAINT achats_pkey PRIMARY KEY (id_achat);


--
-- Name: categorie categorie_categorie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_categorie_key UNIQUE (categorie);


--
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_categorie);


--
-- Name: conversion conversion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversion
    ADD CONSTRAINT conversion_pkey PRIMARY KEY (id_medicament, id_unite_mere);


--
-- Name: laboratoires laboratoires_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratoires
    ADD CONSTRAINT laboratoires_pkey PRIMARY KEY (id_laboratoire);


--
-- Name: maladies maladies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maladies
    ADD CONSTRAINT maladies_pkey PRIMARY KEY (id_maladie);


--
-- Name: maladies_symptomes maladies_symptomes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maladies_symptomes
    ADD CONSTRAINT maladies_symptomes_pkey PRIMARY KEY (id_maladie, id_symptomes);


--
-- Name: medicament_laboratoire medicament_laboratoire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament_laboratoire
    ADD CONSTRAINT medicament_laboratoire_pkey PRIMARY KEY (id_medicament, id_laboratoire, id_unite);


--
-- Name: medicament_status_stock medicament_status_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament_status_stock
    ADD CONSTRAINT medicament_status_stock_pkey PRIMARY KEY (id_medicament, id_status);


--
-- Name: medicaments medicaments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicaments
    ADD CONSTRAINT medicaments_pkey PRIMARY KEY (id_medicament);


--
-- Name: mouvement_stock_details mouvement_stock_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock_details
    ADD CONSTRAINT mouvement_stock_details_pkey PRIMARY KEY (id_mvt_stock_detail);


--
-- Name: mouvement_stock mouvement_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock
    ADD CONSTRAINT mouvement_stock_pkey PRIMARY KEY (id_mvt);


--
-- Name: prix_medicaments prix_medicaments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prix_medicaments
    ADD CONSTRAINT prix_medicaments_pkey PRIMARY KEY (id_prix_medicament);


--
-- Name: reductions reductions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reductions
    ADD CONSTRAINT reductions_pkey PRIMARY KEY (id_reduction);


--
-- Name: status status_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_nom_key UNIQUE (nom);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id_status);


--
-- Name: stock_medicaments stock_medicaments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_medicaments
    ADD CONSTRAINT stock_medicaments_pkey PRIMARY KEY (id_stock_medicament);


--
-- Name: symptomes symptomes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.symptomes
    ADD CONSTRAINT symptomes_pkey PRIMARY KEY (id_symptomes);


--
-- Name: traitements traitements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitements
    ADD CONSTRAINT traitements_pkey PRIMARY KEY (id_maladie, id_medicament, id_categorie);


--
-- Name: type_medicament type_medicament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_medicament
    ADD CONSTRAINT type_medicament_pkey PRIMARY KEY (id_type);


--
-- Name: unites unites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unites
    ADD CONSTRAINT unites_pkey PRIMARY KEY (id_unite);


--
-- Name: utilisateurs utilisateurs_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_email_key UNIQUE (email);


--
-- Name: utilisateurs utilisateurs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateurs
    ADD CONSTRAINT utilisateurs_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: vente_details vente_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente_details
    ADD CONSTRAINT vente_details_pkey PRIMARY KEY (id_vente_detail);


--
-- Name: ventes ventes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventes
    ADD CONSTRAINT ventes_pkey PRIMARY KEY (id_vente);


--
-- Name: achat_details trg_update_total_achat; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_total_achat AFTER INSERT OR UPDATE ON public.achat_details FOR EACH ROW EXECUTE FUNCTION public.update_total_achat();


--
-- Name: vente_details trg_update_total_vente; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_update_total_vente AFTER INSERT OR UPDATE ON public.vente_details FOR EACH ROW EXECUTE FUNCTION public.update_total_vente();


--
-- Name: achat_details achat_details_id_achat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achat_details
    ADD CONSTRAINT achat_details_id_achat_fkey FOREIGN KEY (id_achat) REFERENCES public.achats(id_achat);


--
-- Name: achat_details achat_details_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achat_details
    ADD CONSTRAINT achat_details_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: achat_details achat_details_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achat_details
    ADD CONSTRAINT achat_details_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unites(id_unite);


--
-- Name: achats achats_id_laboratoire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achats
    ADD CONSTRAINT achats_id_laboratoire_fkey FOREIGN KEY (id_laboratoire) REFERENCES public.laboratoires(id_laboratoire);


--
-- Name: conversion conversion_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversion
    ADD CONSTRAINT conversion_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: conversion conversion_id_unite_mere_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversion
    ADD CONSTRAINT conversion_id_unite_mere_fkey FOREIGN KEY (id_unite_mere) REFERENCES public.unites(id_unite);


--
-- Name: maladies_symptomes maladies_symptomes_id_maladie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maladies_symptomes
    ADD CONSTRAINT maladies_symptomes_id_maladie_fkey FOREIGN KEY (id_maladie) REFERENCES public.maladies(id_maladie);


--
-- Name: maladies_symptomes maladies_symptomes_id_symptomes_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maladies_symptomes
    ADD CONSTRAINT maladies_symptomes_id_symptomes_fkey FOREIGN KEY (id_symptomes) REFERENCES public.symptomes(id_symptomes);


--
-- Name: medicament_laboratoire medicament_laboratoire_id_laboratoire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament_laboratoire
    ADD CONSTRAINT medicament_laboratoire_id_laboratoire_fkey FOREIGN KEY (id_laboratoire) REFERENCES public.laboratoires(id_laboratoire);


--
-- Name: medicament_laboratoire medicament_laboratoire_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament_laboratoire
    ADD CONSTRAINT medicament_laboratoire_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: medicament_laboratoire medicament_laboratoire_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament_laboratoire
    ADD CONSTRAINT medicament_laboratoire_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unites(id_unite);


--
-- Name: medicament_status_stock medicament_status_stock_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament_status_stock
    ADD CONSTRAINT medicament_status_stock_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: medicament_status_stock medicament_status_stock_id_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicament_status_stock
    ADD CONSTRAINT medicament_status_stock_id_status_fkey FOREIGN KEY (id_status) REFERENCES public.status(id_status);


--
-- Name: medicaments medicaments_id_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicaments
    ADD CONSTRAINT medicaments_id_type_fkey FOREIGN KEY (id_type) REFERENCES public.type_medicament(id_type);


--
-- Name: mouvement_stock_details mouvement_stock_details_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock_details
    ADD CONSTRAINT mouvement_stock_details_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: mouvement_stock_details mouvement_stock_details_id_mvt_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock_details
    ADD CONSTRAINT mouvement_stock_details_id_mvt_fkey FOREIGN KEY (id_mvt) REFERENCES public.mouvement_stock(id_mvt);


--
-- Name: mouvement_stock_details mouvement_stock_details_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mouvement_stock_details
    ADD CONSTRAINT mouvement_stock_details_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unites(id_unite);


--
-- Name: prix_medicaments prix_medicaments_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prix_medicaments
    ADD CONSTRAINT prix_medicaments_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: prix_medicaments prix_medicaments_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prix_medicaments
    ADD CONSTRAINT prix_medicaments_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unites(id_unite);


--
-- Name: reductions reductions_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reductions
    ADD CONSTRAINT reductions_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: stock_medicaments stock_medicaments_id_laboratoire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_medicaments
    ADD CONSTRAINT stock_medicaments_id_laboratoire_fkey FOREIGN KEY (id_laboratoire) REFERENCES public.laboratoires(id_laboratoire);


--
-- Name: stock_medicaments stock_medicaments_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_medicaments
    ADD CONSTRAINT stock_medicaments_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: stock_medicaments stock_medicaments_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_medicaments
    ADD CONSTRAINT stock_medicaments_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unites(id_unite);


--
-- Name: traitements traitements_id_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitements
    ADD CONSTRAINT traitements_id_categorie_fkey FOREIGN KEY (id_categorie) REFERENCES public.categorie(id_categorie);


--
-- Name: traitements traitements_id_maladie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitements
    ADD CONSTRAINT traitements_id_maladie_fkey FOREIGN KEY (id_maladie) REFERENCES public.maladies(id_maladie);


--
-- Name: traitements traitements_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traitements
    ADD CONSTRAINT traitements_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: unites unites_id_unite_mere_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unites
    ADD CONSTRAINT unites_id_unite_mere_fkey FOREIGN KEY (id_unite_mere) REFERENCES public.unites(id_unite);


--
-- Name: vente_details vente_details_id_medicament_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente_details
    ADD CONSTRAINT vente_details_id_medicament_fkey FOREIGN KEY (id_medicament) REFERENCES public.medicaments(id_medicament);


--
-- Name: vente_details vente_details_id_unite_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente_details
    ADD CONSTRAINT vente_details_id_unite_fkey FOREIGN KEY (id_unite) REFERENCES public.unites(id_unite);


--
-- Name: vente_details vente_details_id_vente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vente_details
    ADD CONSTRAINT vente_details_id_vente_fkey FOREIGN KEY (id_vente) REFERENCES public.ventes(id_vente);


--
-- PostgreSQL database dump complete
--

