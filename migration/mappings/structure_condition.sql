--
-- Migration mapping script for ws structure condition

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_structure_condition;

CREATE TABLE migration.map_structure_condition (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_structure_condition OWNER TO postgres;

INSERT INTO migration.map_structure_condition (old, new) VALUES
(1,	3037), -- Cassé -> unknown
(2,	3037), -- Fissuré -> unknown
(3,	3037), -- Raccordements non soignés -> unknown
(4,	3037), -- Autre -> unknown
(5,	3037), -- Aucun -> unknown
(NULL,	3037) -- NULL  -> unknown
;
