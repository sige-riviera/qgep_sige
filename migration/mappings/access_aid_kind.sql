--
-- Migration script for access aid kind
--
-- Creates mapping table in the sa scheme

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_access_aid_kind;

CREATE TABLE migration.map_access_aid_kind (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_access_aid_kind OWNER TO postgres;

INSERT INTO migration.map_access_aid_kind (old, new) VALUES
(1,	240), -- échelle -> ladder
(2,	91), -- niche, marchepieds -> footsteps_niches
(3,	92), -- sans entrée -> none
(4,	241), -- échelons -> step_iron
(5,	3473), -- escalier -> staircase
(6,	3048), -- inconnu -> unknown
(7,	92), -- pas d'équipement -> none
(10,	5357), -- autre -> other
(NULL,	3048) -- NULL -> inconnu
;
