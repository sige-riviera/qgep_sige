--
-- Migration mapping script for profile types

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_profile_type;

CREATE TABLE migration.map_profile_type (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_profile_type OWNER TO postgres;

INSERT INTO migration.map_profile_type (old, new) VALUES
(1,	3351), -- ovoide
(2,	3350), -- circulaire
(4,	3352), -- profil en voute
(5,	3354), -- profil ouvert
(6,	3353), -- rectangulaire
(7,	3355), -- cunette -> profil special
(8,	3355), -- profil spécial
(9,	3357), -- inconnu
(100,	3355), -- apparent
(101,	3355), -- perfore
(NULL,	3357) -- NULL  -> unknown
;
