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

DROP TABLE IF EXISTS migration.map_reach_material;

CREATE TABLE migration.map_reach_material (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_reach_material OWNER TO postgres;

INSERT INTO migration.map_reach_material (old, new) VALUES
(10008,	5080), -- SIGE
(1, 	2754), -- amiante / ciment -> cement
(2,	3256), -- beton -> concrete unknown
(3, 	3256), -- beton arme -> concrete unknown
(4, 	3256), -- beton prefabrique -> concrete unknown
(5,  	3256), -- beton non arme -> concrete unknown
(6,	3256), -- beton inconnu -> concrete unknown
(7, 	3641), -- beton precontraint -> concrete_special
(8, 	5076), -- resine epoxy armee de fibres -> plastic_epoxy_resin
(9,	147), -- fibrociment -> fiber_cement
(10,  	148), -- fonte -> cast_ductile_iron
(11, 	3639), -- beton coule
(12,	148), -- fonte ductile -> cast_ductile_iron
(13, 	3648),-- fonte grise -> cast_gray_iron
(14,	148), -- fonte inconnue -> cast_ductile_iron
(15,  	5078), -- Element prefabrique en GUP -> plastic_polyester_GUP
(16, 	5382), -- matiere plastique -> unknown plastic
(17,  	5382), -- matiere plastique inconnue -> unknown plastic
(18,	2755), -- maconnerie -> bricks
(19, 	3639), -- beton coule sur place -> concrete_insitu
(20,	3641), -- beton polymere -> concrete_special
(21, 	5077), -- HDPE -> High Density PE
(22, 	5077), -- Polyethylene HD -> High Density PE
(23,	3641), -- beton polymère -> concrete_special
(24,	5080), -- Propylene -> plastic_polypropylene
(25,  	5081), -- PVC -> Plastic PVC
(26, 	5081), -- PVC Dur -> Plastic PVC
(27, 	3641), -- BETON PVC -> concrete_special ?Beton PVC?
(28, 	5081), -- Drain en PVC -> Plastic pvc
(33,  	153), -- ACIER -> steel
(34, 	3654), -- ACIER -> stainless steel
(37, 	2755), -- terre cuite -> bricks
(38,  	3016), -- inconnu -> unknown
(39, 	5078), -- polyester -> plastic polyester GUP
(40, 	5381), -- autre -> other
(41, 	2762), -- ciment -> cement
(42, 	3641), -- beton special arme -> concrete special
(43, 	3641), -- beton special non arme -> concrete special
(100, 	5079), -- PE -> Plastic PE
(101, 	3016), -- NULL -> unknown
(102, 	5077), -- PED -> Plastic HDPE
(103, 	5078), -- PolyEster renforcé de fibres de verre -> plastic Polyester GUP
(10000,	5079), -- SIGE
--(10003,	NULL), -- SIGE
--(10004,	NULL), -- SIGE
(10006,	5081), -- SIGE
(10005,	2754), -- SIGE
--(10007,	NULL), -- SIGE
(10008,	5080), -- SIGE
--(10009,	NULL) -- SIGE
(NULL,	3016) -- NULL -> Unknown
;
