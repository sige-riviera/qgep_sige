--
-- Migration script for elevation determination
--
-- Sets a mapping table for elevation determination

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_elevation_determination;

CREATE TABLE migration.map_elevation_determination (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_elevation_determination OWNER TO postgres;

INSERT INTO migration.map_elevation_determination (old, new) VALUES
(1,	4780), -- précis -> accurate
(2,	4779), -- imprécis -> inaccurate
(3,	4778), -- inconnu -> unkown
(NULL,	4788)  -- NULL -> unkown
;
