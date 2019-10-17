--
-- Migration mapping script for structure type

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_structure_type;

CREATE TABLE migration.map_structure_type (
    old integer,
    new text not NULL
);

ALTER TABLE migration.map_structure_type OWNER TO postgres;

INSERT INTO migration.map_structure_type (old, new) VALUES
--(10005	,'manhole'), --SIGE
--(10006	,'manhole'), --SIGE
--(10003	,'manhole'), --SIGE
--(10002	,'manhole'), --SIGE
(1      ,'special_structure'), -- Ecoulement-> unknown
(2      ,'special_structure'), -- Bassin de décantation -> BEP decantation
(3      ,'special_structure'), -- Ouvrage de chute -> Drop structure
(4	,'manhole'), -- separateur d'hydro  -> Oil separator
-- 5,6,7
(8	,'manhole'), -- sparateur de graisses -> Oil separator
-- 9
(10	,'manhole'), -- évacuation des voies ferroviaires -> rail_track_gully
-- 11, 12
--(13	), --début du canal -> manhole
--(14	),  -- ouverture de chambre
(15	,'special_structure'), --Fosse septique -> septic tank
-- 16,17
(18	,'manhole'), -- chambre de contrôle -> manhole
--19,20,21
(22	,'special_structure'), -- chambre avec pompe -> manhole
--23
(24	,'special_structure'), -- station de pompage -> pumpstation
(26	,'special_structure'), -- deversoir d'orage -> stomwater_tank
(27	,'manhole'), -- recolte des eaux de toiture -> rain_water_manhole
(28	,'manhole'), -- regard de visite -> manhole
(29     ,'special_structure'), -- Chambre de rétention ->stormwater_retention_tank
(32	,'manhole'), -- depotoir -> slurry collector
(33	,'special_structure'), -- chambre avec deversoir de secours -> manhole /define overflow object + overflow function
(34	,'manhole'), -- regard de nettoyage -> manhole (pas d'équivalence)
(35	,'manhole'), -- regard de rincage -> manhole (pas d'équivalence)
(36	,'manhole'), -- chambre spéciale
(37	,'manhole'), -- tuyau de chute par temps sec -> manhole + dryweather flum 
(38	,'manhole'), -- inconnu -> unknown:w
(40	,'discharge_point'), -- rejet au milieu récepteur
(41     ,'infiltration_installation'), -- puits d'infiltration
(42	,'manhole'), -- chambre de jonction
(43     ,'special_structure'), -- chambre tourbillonnaire
(45	,'manhole'), -- chambre avec grille d'entrée
(NULL   ,'manhole') -- NULL -> manhole
;
