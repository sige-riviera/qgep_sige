--
-- Migration mapping script for reach structure condition

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_reach_structure_condition;

CREATE TABLE migration.map_reach_structure_condition (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_reach_structure_condition OWNER TO postgres;

INSERT INTO migration.map_reach_structure_condition (old, new) VALUES
(2,	3363), -- Ne fonctionne plus -> Z0
(3,	3359), -- Défauts graves -> Z1
(4,	3360), -- Défauts moyens -> Z2
(5,	3361), -- Défauts légérs -> Z3
(6,	3362), -- Aucun défaut -> Z4
(NULL,	3037) -- NULL  -> unknown
;
