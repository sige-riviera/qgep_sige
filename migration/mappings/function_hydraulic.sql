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
-- Name: map_function_hydraulic; Type: TABLE; Schema: sa; Owner: postgres; Tablespace: 
--

DROP TABLE IF EXISTS map_function_hydraulic;

CREATE TABLE map_function_hydraulic (
    old integer NOT NULL,
    new integer NOT NULL
);


ALTER TABLE sa.map_function_hydraulic OWNER TO postgres;

--
-- TOC entry 5386 (class 0 OID 484607)
-- Dependencies: 584
-- Data for Name: map_function_hydraulic; Type: TABLE DATA; Schema: sa; Owner: postgres
--

COPY map_function_hydraulic (old, new) FROM stdin;
2	23
5	367
10	5321
\.


--
-- TOC entry 5228 (class 2606 OID 484611)
-- Name: map_function_hydraulic_pkey; Type: CONSTRAINT; Schema: sa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY map_function_hydraulic
    ADD CONSTRAINT map_function_hydraulic_pkey PRIMARY KEY (old, new);


-- Completed on 2015-06-02 18:12:52 CEST

--
-- PostgreSQL database dump complete
--

