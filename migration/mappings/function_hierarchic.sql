--
-- Migration Mapping script for collectors

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = sa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

DROP TABLE IF EXISTS map_function_hierarchic;

CREATE TABLE map_function_hierarchic (
    old integer,
    new integer NOT NULL
);


ALTER TABLE sa.map_function_hierarchic OWNER TO postgres;

INSERT INTO map_function_hierarchic (old, new) VALUES 
(1,	5064), -- Evacuation des eaux de bien-fonds -> pwwf.residential_drainage
(2,	5072), -- Evacuation des eaux de voies ferrees -> pwwf.road_drainage
(3,	5069), -- Collecteur principal -> main_drain
(4,	5068), -- Eaux publiques -> pwwf.water_bodies
(5,	5069), -- Collecteur d'accumulation -> main_drain
(6,	5062), -- Conduite d'assainissement -> pwwf.renovation_conduction
(7,	5072), -- Evacuation des eaux de routes -> pwwf.road_drainage 
(8,	5069), -- Conduite de transport -> main_drainage
(9,	5074), -- inconnu -> unknown primary
(100,	5064), -- prive -> pwwf.residential_drainage
(101,	5075), -- collecteur secondaire -> secondary unknown
(NULL,	5074) -- null -> unkown primary
;
