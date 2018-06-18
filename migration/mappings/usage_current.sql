--
-- Migration mapping script for current usage

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_usage_current;

CREATE TABLE migration.map_usage_current (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_usage_current OWNER TO postgres;

INSERT INTO migration.map_usage_current (old, new) VALUES
(1,	4524), -- Eaux industrielles -> industrial wastewater
(2,	4571), -- conduite de drainage -> inconnu / ajouter channel_function hydraulic seepage waterdrain	
(4,	4522), -- Eaux mixtes -> combined wastewater
(5,	4520), -- Eaux pluviales -> rain_wastewater
(6,	4526), -- Eaux usées -> wastewater
(7,	4571), -- inconnu -> unknown
(10,	5322), -- tout a l'égout -> combined wastewater
(11,	4514), -- Eaux claires -> clean wastewater
(12,	5322), -- inconnu au bataillon -> DOC SIGE?
(NULL,	4571) -- NULL -> unknown
;
