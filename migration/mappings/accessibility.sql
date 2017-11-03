--
-- Migration mapping script for ws accessibility

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = sa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

DROP TABLE IF EXISTS map_accessibility;

CREATE TABLE map_accessibility (
    old integer,
    new integer NOT NULL
);

ALTER TABLE sa.map_accessibility OWNER TO postgres;

INSERT INTO map_accessibility (old, new) VALUES
(1,	3444), --couvert -> covered
(2,	3447), --inconnu -> unknown
(3,	3445), --accessible -> acessible
(4,	3446), --non accessible -> inaccessible
(100,	3447), -- autre -> unknown
(101,	3445), -- couvercle vissé  -> accessible
(102,	3444), -- couvercle enterré -> covered
(NULL,	3447) -- NULL -> unknown
;
