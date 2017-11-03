--
-- Migration mapping script for cover fastening

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = sa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

DROP TABLE IF EXISTS map_cover_fastening;

CREATE TABLE map_cover_fastening (
    old integer,
    new integer NOT NULL
);

ALTER TABLE sa.map_cover_fastening OWNER TO postgres;

INSERT INTO map_cover_fastening (old, new) VALUES
(1,	5350), --anguleux -> not bolted
(2,	5352), --anguleux vissé -> bolted
(3,	5350), --rond -> not bolted
(4,	5350), -- rond vissé -> bolted
(5,	5351), -- BLANK -> unknown
(NULL,	5351) -- NULL  -> unknown
;
