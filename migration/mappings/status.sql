--
-- Migration mapping script for status

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_status;

CREATE TABLE migration.map_status (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_status OWNER TO postgres;

INSERT INTO migration.map_status (old, new) VALUES
(1,	8493), -- existant -> operationnal
(2,	7959), -- planifie -> planned
(3,	6526), -- fictif -> calculation alternative
(4,	3633), -- hors service -> inoperative
(5,	6532), -- condamne -> abandonned filled
(6,	8493), -- changement de fonction -> operationnal
(7,	6532), -- abandonne -> 
(8,	8493), -- a remplacer -> operationnal
(9,	3633), -- aboli -> inoperative
(10,	6530), -- provisoire -> operationnal tentative
(11,	3027), -- inconnu -> unknown
(12,	3027), -- autre -> unknown
(100,	8493), -- en service -> operationnal
(101,	6530), -- en reserve -> operationnal tentative
(NULL,	3027) -- NULL -> unknown
;
