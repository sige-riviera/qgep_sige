--
-- Migration mapping script for horizontal positioning

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = sa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

DROP TABLE IF EXISTS map_horizontal_positioning;

CREATE TABLE map_horizontal_positioning (
    old integer,
    new integer NOT NULL
);

ALTER TABLE sa.map_horizontal_positioning OWNER TO postgres;

INSERT INTO map_horizontal_positioning (old, new) VALUES
(4,	5379), -- inconnu -> unknown
(3,	5380), -- imprécis -> inaccurate
(2,	5378), -- précis -> accurate
(1,	5380), -- digitalise -> inaccurate
(NULL,	5379) -- NULL -> unknown
;
