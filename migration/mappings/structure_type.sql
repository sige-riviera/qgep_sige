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

--

DROP TABLE IF EXISTS map_manhole_function;

CREATE TABLE map_manhole_function (
    old integer NOT NULL,
    new integer
);


ALTER TABLE sa.map_manhole_function OWNER TO postgres;

--

INSERT INTO map_manhole_function (old, new) VALUES
(10005,	204), --SIGE
(10006,	204), --SIGE
(10003,	204), --SIGE
(10002,	4536), --SIGE
(3,	4532), -- drop_structure
(4,	1008), -- separateur d'hydro  -> Oil separator
(8,	1008), -- sparateur de graisses -> Oil separator
(10,	228), -- évacuation des voies ferroviaires -> rail_track_gully
(13,	204), --début du canal -> manhole
(14,	204),  -- ouverture de chambre
(18,	204), -- chambre de contrôle -> manhole
(22,	204), -- chambre avec pompe -> manhole
(24,	4536), -- station de pompage -> pumpstation
(26,	5346), -- deversoir d'orage -> stomwater_tank
(27,	3267), -- recolte des eaux de toiture -> rain_water_manhole
(28,	204), -- regard de visite -> manhole
(32,	2742), -- depotoir -> slurry collector
(33,	204), -- chambre avec deversoir de secours -> manhole /define overflow object + overflow function
(34,	204), -- regard de nettoyage -> manhole (pas d'équivalence)
(35,	204), -- regard de rincage -> manhole (pas d'équivalence)
(37,	204), -- tuyau de chute par temps sec -> manhole + dryweather flum 
(38,	5345) -- inconnu -> unknown:w
;


ALTER TABLE ONLY map_manhole_function
    ADD CONSTRAINT map_manhole_function_pkey PRIMARY KEY (old);

