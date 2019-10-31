--
-- Migration mapping script for se type

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_se_type;

CREATE TABLE migration.map_se_type (
    old integer,
    new integer not NULL
);

ALTER TABLE migration.map_se_type OWNER TO postgres;

INSERT INTO migration.map_se_type (old, new) VALUES
(1	,10101), -- Buanderie
(2	,10102), -- Caillebotis
(3	,10103), -- Chéneau
(4	,10104), -- Colonne de chute
(5	,10105), -- Cusine
(6	,10106), -- Evier
(7	,10107), -- Raccordement
(8	,10108), -- Séparateur
(9	,10109), -- WC
(10	,10110) -- Chambre de visite
;
