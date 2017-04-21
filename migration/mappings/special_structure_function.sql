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

DROP TABLE IF EXISTS map_special_structure_function;

CREATE TABLE map_special_structure_function (
    old integer NOT NULL,
    new integer
);


ALTER TABLE sa.map_special_structure_function OWNER TO postgres;

--

INSERT INTO map_special_structure_function (old, new) VALUES
(1 ,    3008), -- Ecoulement-> special_structure ??
(2 ,    3673), -- Bassin de décantation -> BEP_decantation
(15,	6478), -- Fosse septique -> septic tank
(29,	3676), -- Chambre de rétention -> stormwater_retention_tank
(36,	2998), -- chambre speciale -> special structure + type manhole
(43,	2745) -- chambre tourbillonnaire -> vortex_manhole
--24      4536
--26      5346
--36      \N
--38      5345
;


ALTER TABLE ONLY map_special_structure_function
    ADD CONSTRAINT map_special_structure_function_pkey PRIMARY KEY (old);

