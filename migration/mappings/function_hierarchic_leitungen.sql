--
-- Migration mapping script 

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = sa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

DROP TABLE IF EXISTS map_function_hierarchic_leitungen;

CREATE TABLE map_function_hierarchic_leitungen (
    old integer,
    new integer NOT NULL
);

ALTER TABLE sa.map_function_hierarchic_leitungen OWNER TO postgres;

INSERT INTO map_function_hierarchic_leitungen (old, new) VALUES 
(1,	5065), -- évacuation des eaux de bâtiments -> swwf.residential_drainage
(2,	5065), -- évacuation des eaux de bien fonds -> swwf.residential_drainage
(3,	5069), -- conduite de transport -> swwf.main_drain // la notion de transport est reprise dans vl_channel_function
(100,	5069), -- primaire -> pwwf.main_drain
(101,	5075), -- Clarify with exploitation road / renovation conduction / residential
(NULL,	5075) -- null -> unkown secondary
;
