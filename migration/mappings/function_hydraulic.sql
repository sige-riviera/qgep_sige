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

DROP TABLE IF EXISTS map_function_hydraulic;

CREATE TABLE map_function_hydraulic (
    old integer,
    new integer NOT NULL
);


ALTER TABLE sa.map_function_hydraulic OWNER TO postgres;

COPY map_function_hydraulic (old, new) FROM stdin;
2	23
5	367
10	5321
\N	5321
\.

