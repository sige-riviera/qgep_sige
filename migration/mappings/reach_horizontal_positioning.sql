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
-- Name: map_horizontal_positioning; Type: TABLE; Schema: sa; Owner: postgres; Tablespace: 
--

DROP TABLE IF EXISTS map_horizontal_positioning;

CREATE TABLE map_horizontal_positioning (
    old integer NOT NULL,
    new integer NOT NULL
);


ALTER TABLE sa.map_horizontal_positioning OWNER TO postgres;

--
-- TOC entry 5386 (class 0 OID 484607)
-- Dependencies: 584
-- Data for Name: map_horizontal_positioning; Type: TABLE DATA; Schema: sa; Owner: postgres
--

INSERT INTO map_horizontal_positioning (old, new) VALUES
(4,	5379), -- unknown
(3,	5380), -- inaccurate
(2,	5378), -- accurate 
(1,	5378) -- accurate
;


--
-- TOC entry 5228 (class 2606 OID 484611)
-- Name: map_horizontal_positioning_pkey; Type: CONSTRAINT; Schema: sa; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY map_horizontal_positioning
    ADD CONSTRAINT map_horizontal_positioning_pkey PRIMARY KEY (old, new);


-- Completed on 2015-06-02 18:12:52 CEST

--
-- PostgreSQL database dump complete
--

