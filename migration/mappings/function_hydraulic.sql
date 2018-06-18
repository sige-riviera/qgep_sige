--
-- Migration mapping script for hydraulic functions
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_function_hydraulic;

CREATE TABLE migration.map_function_hydraulic (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_function_hydraulic OWNER TO postgres;

INSERT INTO migration.map_function_hydraulic (old, new) VALUES
(1,     5320), -- Cunette -> other
(2,     23), -- Conduite de refoulement -> pump_pressure_pipe
(3,     22), -- Conduite de retrecissement -> restriction pipe
(4,     3610), -- Syphon inversé -> inverted syphon
(5,     367), -- Conduite a ecoulement libre -> gravity_pipe
(6,	367), -- Conduite d'assainissement -> gravity_pipe
(6,     5320), -- conduite d'infiltration ou de drainage -> other
(7,     21), -- conduite d'accumulation -> retention_pipe
(8,     2546), -- Conduite de transport -> drainage_transportation_pipe
(9,     144), -- Conduite de rincage -> jetting_pipe
(10,    5321), -- inconnu -> unknown
(11,    5320), -- exutoire -> other
(12,    21), -- conduite d'accumulation -> retention_pipe
(13,    5320), -- autre -> other
(14,    367), -- Evacuation des eaux de routes -> gravity_pipe
(15,    367), -- Evacuation des eaux de bâtiments -> gravity_pipe
(16,    367), -- Evacuation des eaux de routes et de bâtiments -> gravity_pipe
(17,    367), -- Evacuation des eaux de bien-fonds -> gravity_pipe
(18,    367), -- Evacuation des eaux traitées à la STEP -> gravity_pipe
(19,    367), -- Evacuation eau potable -> gravity_pipe
(NULL,  5321) -- null -> unkown
;
