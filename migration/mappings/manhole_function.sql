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

DROP TABLE IF EXISTS map_structure_type;

CREATE TABLE map_structure_type (
    old integer NOT NULL,
    new text
);


ALTER TABLE sa.map_structure_type OWNER TO postgres;

--'manhole'

INSERT INTO map_structure_type (old, new) VALUES
(10005	,'manhole'), --SIGE
(10006	,'manhole'), --SIGE
(10003	,'manhole'), --SIGE
(10002	,'manhole'), --SIGE
(3	,'manhole'), -- drop_structure
(4	,'manhole'), -- separateur d'hydro  -> Oil separator
(8	,'manhole'), -- sparateur de graisses -> Oil separator
(10	,'manhole'), -- évacuation des voies ferroviaires -> rail_track_gully
(13	,'manhole'), --début du canal -> manhole
(14	,'manhole'),  -- ouverture de chambre
(18	,'manhole'), -- chambre de contrôle -> manhole
(22	,'manhole'), -- chambre avec pompe -> manhole
(24	,'manhole'), -- station de pompage -> pumpstation
(26	,'manhole'), -- deversoir d'orage -> stomwater_tank
(27	,'manhole'), -- recolte des eaux de toiture -> rain_water_manhole
(28	,'manhole'), -- regard de visite -> manhole
(32	,'manhole'), -- depotoir -> slurry collector
(33	,'manhole'), -- chambre avec deversoir de secours -> manhole /define overflow object + overflow function
(34	,'manhole'), -- regard de nettoyage -> manhole (pas d'équivalence)
(35	,'manhole'), -- regard de rincage -> manhole (pas d'équivalence)
(37	,'manhole'), -- tuyau de chute par temps sec -> manhole + dryweather flum 
(38	,'manhole'), -- inconnu -> unknown:w
(1	,'special_structure'),
(2	,'special_structure'),
(15	,'special_structure'),
(29	,'special_structure'),
(36	,'special_structure'),
(43	,'special_structure'),
(41	,'infiltration_installation')
;


ALTER TABLE ONLY map_structure_type
    ADD CONSTRAINT map_structure_type_pkey PRIMARY KEY (old);

