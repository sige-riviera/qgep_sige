--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.6
-- Dumped by pg_dump version 9.3.6
-- Started on 2015-06-02 18:12:52 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = sa, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 584 (class 1259 OID 484607)
-- Name: map_reach_material; Type: TABLE; Schema: sa; Owner: postgres; Tablespace: 
--

DROP TABLE IF EXISTS map_reach_material;

CREATE TABLE map_reach_material (
    old integer NOT NULL,
    new integer
);


ALTER TABLE sa.map_reach_material OWNER TO postgres;

--
-- TOC entry 5386 (class 0 OID 484607)
-- Dependencies: 584
-- Data for Name: map_reach_material; Type: TABLE DATA; Schema: sa; Owner: postgres
--

INSERT INTO map_reach_material (old, new) VALUES
(10008,	5080), -- SIGE
(1    , 2754), -- amiante / ciment -> cement
(2,	3256), -- beton -> concrete unknown
(3    , 3256), -- beton arme -> concrete unknown
(4, 3256), -- beton prefabrique -> concrete unknown
(5    ,  3256), -- beton non arme -> concrete unknown
(7    ,  5079), -- SIGE
(8, 5076), -- resine epoxy armee de fibres -> plastic_epoxy_resin
(10   ,  148), -- fonte -> cast_ductile_iron
(11, 3639), -- beton coule
(13, 3648),-- fonte grise -> cast_gray_iron
(15,  5078), -- SIGE
(16, 5382), -- matiere plastique -> unknown plastic
(17,  5382), -- matiere plastique inconnue -> unknown plastic
--(18, \N), -- maconnerie -> SIGE 
(21, 5077), -- HDPE -> High Density PE
(22, 5077), -- Polyethylene HD -> High Density PE
(25,  5081), -- PVC -> Plastic PVC
(26, 5081), -- PVC Dur -> Plastic PVC
(27, 5081), -- BETON PVC -> Plastic PVC ?Beton PVC?
--(28,  \N), --SIGE
(33,  153), -- ACIER -> steel
(34, 3654), -- ACIER -> stainless steel
(37, 2755), -- terre cuite -> bricks
(38,  3016), -- inconnu -> unknown
(39, 5078), -- polyester -> plastic polyester GUP
(40, 5381), -- autre -> other
(41, 2762), -- ciment -> cement
(42, 3641), -- beton special arme -> concrete special
(43, 3641), -- beton special non arme -> concrete special
(100, 5079), -- PE -> Plastic PE
(101, 3016), -- NULL -> unknown
(102, 5077), -- PED -> Plastic HDPE
(103, 5078), -- PolyEster renforcé de fibres de verre -> plastic Polyester GUP 
(10000,	5079), -- SIGE
--(10003,	\N), -- SIGE
--(10004,	\N), -- SIGE
(10006,	5081), -- SIGE
(10005,	2754) -- SIGE
--(10007,	\N), -- SIGE
--(10009,	\N) -- SIGE
;


--
-- TOC entry 5228 (class 2606 OID 484611)
-- Name: map_reach_material_pkey; Type: CONSTRAINT; Schema: sa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY map_reach_material
    ADD CONSTRAINT map_reach_material_pkey PRIMARY KEY (old);


-- Completed on 2015-06-02 18:12:52 CEST

--
-- PostgreSQL database dump complete
--

