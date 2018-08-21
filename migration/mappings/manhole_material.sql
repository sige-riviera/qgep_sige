--
-- Migration mapping script for materials

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_manhole_material;

CREATE TABLE migration.map_manhole_material (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_manhole_material OWNER TO postgres;

INSERT INTO migration.map_manhole_material (old, new) VALUES
(1, 	4540), -- amiante / ciment -> other
(2,	4541), -- beton arme -> concrete
(3, 	4541), -- element en beton préfabrique -> concrete
(4, 	4541), -- beton non arme -> concrete
(5,  	4541), -- fibrociment -> concrete
(6,	4541), -- beton coule -> concrete
(7, 	4540), -- fonte ductile -> other
(8, 	4540), -- fibre de verre rencforcée -> other
(9,	4540), -- fonte grise -> other
(10,  	4542), -- Element en GUP préfabriqué -> plastic
(11, 	4541), -- Maconnerie -> beton
(12,	4541), -- beton coulé sur place -> concrete
(13, 	4541), -- beton polymere -> concrete
(14,	4542), -- polyethylene HD -> plastic
(15,  	4541), -- beton polyester dur -> concrete
(16, 	4542), -- polypropylene -> plastic
(17,  	4542), -- chlorure de polyvinyle PVC -> plastic
(18,	4541), -- beton acier -> concrete
(19, 	4540), -- acier oxydable -> other
(20,	4540), -- acier inoxydable -> other
(21, 	4540), -- grès -> other
(22, 	4543), -- inconnu -> unkown
(23,	4541), -- beton special arme -> concrete
(24,	4541), -- beton special non arme -> concrete
(100, 	4541), -- beton -> concrete
(101, 	4540), -- acier -> other
(102, 	4540), -- fonte beton coule -> other
(103, 	4540), -- fonte -> other
(104,	4540), -- Polyester renforcé de fibre de verre -> other
(NULL,	4543)  -- NULL -> Unknown
;
