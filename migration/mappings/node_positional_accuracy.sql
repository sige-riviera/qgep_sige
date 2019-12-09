--
-- Migration mapping script for node_positional_accuracy

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_node_positional_accuracy;

CREATE TABLE migration.map_node_positional_accuracy (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_node_positional_accuracy OWNER TO postgres;

INSERT INTO migration.map_node_positional_accuracy (old, new) VALUES
(4,	14778), -- inconnu -> unknown
(3,	14779), -- imprécis -> inaccurate
(2,	14780), -- précis -> accurate
(1,	14779), -- digitalise -> inaccurate
(NULL,	14778) -- NULL -> unknown
;
