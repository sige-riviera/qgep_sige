--
-- Migration mapping script for node type

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_node_type;

CREATE TABLE migration.map_node_type (
    old integer,
    new integer not NULL
);

ALTER TABLE migration.map_node_type OWNER TO postgres;

INSERT INTO migration.map_node_type (old, new) VALUES
(13	,10002), -- Début du cannal
(5	,10003), -- Changement d'année de construction
(17	,10004), -- Changement de matériau/diamètre
(16	,10005), -- Changement de diamètre
(21	,10006), -- Changement de matériau
(9	,10007), -- Changement de pente
(19	,10008) -- Raccord de collecteur
;
