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

COPY map_reach_material (old, new) FROM stdin;
10008	5080
1	2762
3	\N
5	\N
7	5079
10	148
15	5078
18	\N
25	5081
28	\N
33	153
38	3016
10000	5079
10003	\N
10004	\N
10006	5081
10005	2754
10007	\N
10009	\N
\.


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

