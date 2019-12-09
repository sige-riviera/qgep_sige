--
-- Migration mapping script for cover_positional_accuracy

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_cover_positional_accuracy;

CREATE TABLE migration.map_cover_positional_accuracy (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_cover_positional_accuracy OWNER TO postgres;

INSERT INTO migration.map_cover_positional_accuracy (old, new) VALUES
(4,	15379), -- inconnu -> unknown
(3,	15380), -- imprécis -> inaccurate
(2,	15378), -- précis -> accurate
(1,	15380), -- digitalise -> inaccurate
(NULL,	15379) -- NULL -> unknown
;
