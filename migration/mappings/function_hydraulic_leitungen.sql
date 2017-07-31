--
-- Migration mapping script for hydraulic functions
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = sa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

DROP TABLE IF EXISTS map_function_hydraulic_leitungen;

CREATE TABLE map_function_hydraulic_leitungen (
    old integer,
    new integer NOT NULL
);

ALTER TABLE sa.map_function_hydraulic_leitungen OWNER TO postgres;

INSERT INTO map_function_hydraulic_leitungen (old, new) VALUES
(1,     5320), -- Cunette -> other
(2,     5320), -- conduite d'infiltration ou de drainage -> other
(3,    	367), -- Evacuation des eaux de routes -> gravity_pipe
(4,    	367), -- Evacuation des eaux de bâtiments -> gravity_pipe
(5,    	367), -- Evacuation des eaux de routes et de bâtiments -> gravity_pipe
(6,    	367), -- Evacuation des eaux de bien-fonds -> gravity_pipe
(8,    	367), -- Evacuation des eaux traitées à la STEP -> gravity_pipe
(9,    	367), -- Evacuation eau potable -> gravity_pipe
(10,    5320), -- exutoire -> other
(11,	23), -- Conduite de refoulement -> pump_pressure_pipe
(NULL,  5321) -- null -> unkown
;
