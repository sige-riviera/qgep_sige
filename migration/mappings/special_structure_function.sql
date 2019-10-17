--
-- Migration mapping script for special structures function

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET search_path = migration, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS migration.map_special_structure_function;

CREATE TABLE migration.map_special_structure_function (
    old integer,
    new integer NOT NULL
);

ALTER TABLE migration.map_special_structure_function OWNER TO postgres;

INSERT INTO migration.map_special_structure_function (old, new) VALUES
--
--
--
--
(1 ,    3008), -- Ecoulement-> unknown
(2 ,    3673), -- Bassin de décantation -> BEP_decantation
(3,     245), -- ouvrage de chute -> drop_structure
--(4,     1008), -- separateur d'hydro  -> Oil separator
--(5,   ), -- Changement annee construction
--(8,     1008), -- sparateur de graisses -> Oil separator
--(9,   ), -- Changement de pente
--(10,  228), -- évacuation des voies ferroviaires -> rail_track_gully (absent à Pully)
--(12,  ) -- siphon de cour ->
--(13,  ), -- début du canal -> manhole
--(14,  ),  -- ouverture de chambre (absent à Pully)
(15,	6478), -- Fosse septique -> septic tank
--(16,  ) -- Changement de dimension
--(17,  ) -- Changement de calibre / matériau
--(18,  ), -- chambre de contrôle -> manhole
--(19,  ), -- raccord de collecteur
--(20,  ), -- (absent à Pully)
--(21,  ), -- Changement de matériau
(22,    246), -- chambre avec pompe -> station de pompage
--(23,  ) -- puisart (absent à Pully)
(24,    246), -- station de pompage -> pumpstation
(26,    5372), -- deversoir d'orage -> stomwater_tank
--(27,    3267), -- recolte des eaux de toiture -> rain_water_manhole
--(28,    204), -- regard de visite -> manhole
(29,	3676), -- Chambre de rétention -> stormwater_retention_tank
--(32,    2742), -- depotoir -> slurry collector
--(33,  204), -- chambre avec deversoir de secours -> manhole (absent à Pully)
--(34,  204), -- regard de nettoyage -> manhole (pas d'équivalence)
--(35,  204), -- regard de rincage -> manhole (pas d'équivalence)
--(36,	2998), -- chambre speciale -> special structure + type manhole
--(37,  204), -- tuyau de chute par temps sec -> manhole + dryweather flum (absent à Pully)
(38,	3008), -- inconnu -> unkown
--(40,  ), -- rejet au mileu récepteur -> exutoire au milieu récepteur
--(41,  ), -- puits d'infiltration -> installation d'infiltration
--(42,    204), -- chambre de jonction -> manhole
(43,	2745) -- chambre tourbillonnaire -> vortex_manhole
--(45,    3266), -- chambre avec grille d'entrée -> chambre avec grille d'entrée
--(NULL,	3008) -- NULL -> unkown
;
