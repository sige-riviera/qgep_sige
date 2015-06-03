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
-- Name: map_status; Type: TABLE; Schema: sa; Owner: postgres; Tablespace: 
--

CREATE TABLE map_status (
    old integer NOT NULL,
    new integer NOT NULL
);


ALTER TABLE sa.map_status OWNER TO postgres;

--
-- TOC entry 5386 (class 0 OID 484607)
-- Dependencies: 584
-- Data for Name: map_status; Type: TABLE DATA; Schema: sa; Owner: postgres
--

COPY map_status (old, new) FROM stdin;
1	6528
3	6526
4	3633
6	6530
7	3027
\.


--
-- TOC entry 5228 (class 2606 OID 484611)
-- Name: map_status_pkey; Type: CONSTRAINT; Schema: sa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY map_status
    ADD CONSTRAINT map_status_pkey PRIMARY KEY (old, new);


-- Completed on 2015-06-02 18:12:52 CEST

--
-- PostgreSQL database dump complete
--

