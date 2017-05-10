--
-- Migration mapping script for materials
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

DROP TABLE IF EXISTS map_reach_material_leitungen;

CREATE TABLE map_reach_material_leitungen (
    old integer,
    new integer NOT NULL
);

ALTER TABLE sa.map_reach_material_leitungen OWNER TO postgres;

INSERT INTO map_reach_material_leitungen (old, new) VALUES
(1,     2754), -- amiante / ciment -> cement
(2,     3256), -- beton arme -> concrete unknown
(3,     3256), -- beton prefabrique -> concrete unknown
(4,     3256), -- beton non arme -> concrete unknown
(5,     147), -- fibrociment -> fiber_cement
(6,    	3639), -- fonte beton coule -> concrete_insitu
(7,	148), -- fonte ductile -> cast_ductile_iron
(8,	5078), -- fibre de verre renforce -> plastic Polyester GUP
(9,	3648),-- fonte grise -> cast_gray_iron
(10,	5078), -- Element prefabrique en GUP -> plastic_polyester_GUP
(11,	2755), -- maconnerie -> bricks
(12,	3639), -- beton coule sur place -> concrete_insitu
(13,	3641), -- beton polymère -> concrete_special
(14,	5077), -- Polyethylene HD -> High Density PE
(15,	3641), -- beton polyester dur -> concrete_special
(16,	5080), -- Polypropylene -> plastic_polypropylene
(17,	5081), -- Chlorure de Polyvinyle PVC -> Plastic PVC
(19,	153), -- Acier oxydable -> steel
(20,	3654), -- Acier inoxydable -> stainless steel
(21,	5381), -- grès -> other
(22,	3016), -- inconnu -> unknown
(23,	3641), -- beton special arme -> concrete special
(24,	3641), -- beton special non arme -> concrete special
(100,	153), -- acier -> steel
(101,	5081), -- Chlorure de Polyvinyle PVC -> Plastic PVC
(102,	5076), -- resine epoxy armee de fibres -> plastic_epoxy_resin
(103,	5078), -- polyester non sature -> plastic polyester GUP
(104,	5079), -- Polyethylene -> Plastic PE
(105,	5078), -- polyester -> plastic polyester GUP
(106,	3256), -- beton -> concrete unknown
(NULL,  3016) -- NULL -> Unknown
;
