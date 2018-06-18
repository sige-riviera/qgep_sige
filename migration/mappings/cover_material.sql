--
-- Migration mapping script for cover materials

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_cover_material;

CREATE TABLE migration.map_cover_material (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_cover_material OWNER TO postgres;

INSERT INTO migration.map_cover_material (old, new) VALUES
(1, 	234), -- amiante / ciment -> concrete
(2,	234), -- beton armé -> concrete
(3, 	234), -- beton prefabrique -> concrete
(4,  	234), -- beton non arme -> concrete
(5,	234), -- fibrociment -> concrete
(6, 	234), -- beton coulé -> concrete
(7, 	233), -- fonte ductile -> cast iron (fonte)
(8,	5355), -- fibre de verre renforcée -> other
(9,  	233), -- fonte grise-> cast iron
(10, 	5355), -- Element en GUP préfabriqué -> other
(11,	5355), -- maçonnerie -> other
(12, 	234),-- béton coulé sur place -> concrete
(13,	234), -- béton polymère -> concrete
(14,  	5355), -- polyethylene HD -> other
(15, 	234), -- beton polyester dur -> concrete
(16,  	5355), -- polypropylene -> other
(17,	5355), -- PVC -> other
(18, 	234), -- beton acier -> concrete
(19,	5355), -- acier ox -> other
(20, 	5355), -- acier inox -> other
(21, 	5355), -- grès -> other
(22,	3015), -- inconnu -> unknown
(23,	234), -- beton armé spécial -> concrete
(24,  	234), -- béton non armé spécial -> concrete
(100, 	234), -- béton -> concrete
(101, 	5355), -- acier -> other
(102, 	235), -- fonte béton coulé -> cast iron with concrete filling
(103,  	233), -- fonte -> cast iron
(104, 	5355), -- Polyester renforcé -> other
(NULL, 	3015) -- NULL -> unknown
;
