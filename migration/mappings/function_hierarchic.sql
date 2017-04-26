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
(1,	5069), -- Cunette -> main drain
(2,	5069), -- Conduite de refoulement -> main drain
(3,	5069), -- Conduite de retrecissement -> main drain
(4,	5069), -- Syphon inversé -> main drain
(5,	5069), -- Conduite a ecoulement libre -> main drain
(6,	5069), -- conduite d'infiltration ou de drainage -> main drain
(7,	5069), -- conduite d'accumulation -> main drain
(8,	5069), -- Conduite de transport -> main_drain
(9,	5069), -- Conduite de rincage -> 
(10,	5074), -- inconnu -> unknown primary
(11,	5069), -- exutoire -> main drain
(12,	5069), -- conduite d'accumulation
(13,	5066), -- autre -> pwwf.other
(14,	5072), -- Evacuation des eaux de routes -> pwwf.road_drainage
(15,	5064), -- Evacuation des eaux de bâtiments -> pwwf.residential_drainage
(16,	5072), -- Evacuation des eaux de routes et de bâtiments -> pwwf.road_drainage
(17,	5064), -- Evacuation des eaux de bien-fonds -> pwwf.residential_drainage
(18,	5069), -- Evacuation des eaux traitées à la STEP -> main_drain
(19,	5064), -- Evacuation eau potable -> pwwf.main_drain
(NULL,	5074) -- null -> unkown primary
;
