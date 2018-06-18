--
-- Migration mapping script for cover shape

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_cover_shape;

CREATE TABLE migration.map_cover_shape (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_cover_shape OWNER TO postgres;

INSERT INTO migration.map_cover_shape (old, new) VALUES
(1,	3499), --anguleux -> anguleux (rectangle)
(2,	3499), --anguleux vissé -> anguleux (rectangle)
(3,	3498), --rond -> round
(4,	3498), -- rond vissé -> round
(5,	5354), -- BLANK -> unknown
(NULL,	5354) -- NULL  -> unknown
;
