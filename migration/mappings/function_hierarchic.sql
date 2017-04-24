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
-- Name: map_function_hierarchic; Type: TABLE; Schema: sa; Owner: postgres; Tablespace: 
--
DROP TABLE IF EXISTS map_function_hierarchic;

CREATE TABLE map_function_hierarchic (
    old integer,
    new integer NOT NULL
);


ALTER TABLE sa.map_function_hierarchic OWNER TO postgres;

--
-- TOC entry 5386 (class 0 OID 484607)
-- Dependencies: 584
-- Data for Name: map_function_hierarchic; Type: TABLE DATA; Schema: sa; Owner: postgres
--

INSERT INTO map_function_hierarchic (old, new) VALUES 
(3,	5069), -- Collecteur principal -> main drain
(8,	5069), -- Conduite de transport -> main_drain
(9,	5074), -- inconnu -> main unknown
(101,	5075), -- collecteur secondaire -> secondary unknown
(NULL,	5074) -- null -> unkown primary
;
--
-- TOC entry 5228 (class 2606 OID 484611)
-- Name: map_function_hierarchic_pkey; Type: CONSTRAINT; Schema: sa; Owner: postgres; Tablespace: 
--

--ALTER TABLE ONLY map_function_hierarchic
--    ADD CONSTRAINT map_function_hierarchic_pkey PRIMARY KEY (old, new);


-- Completed on 2015-06-02 18:12:52 CEST

--
-- PostgreSQL database dump complete
--

