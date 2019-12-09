/***************************************************************************
    TopoBase2 to QGEP migration script for
     * Covers
     * Manholes
     * Special Structures
     * Discharge points
     * Infiltration Installations
     --------------------------------------
    Date                 : 1.6.2015
    Copyright            : (C) 2015 Matthias Kuhn
    Email                : matthias at opengis dot ch
     -------------------------------------
    Pimped by Arnaud Poncet-Montanges 2017
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/**
 * This script temporarily sets the identifier of the wastewater structure (manhole)
 * to the old fid. This is done in order to allow adding access aids based on the fid
 * subsequently.
 * At the end of the script the old fid is replaced with the real identifier.
 */

/*
WITH netzlinien AS (
SELECT
  gid,
--  ST_Fineltra(ST_SetSRID(ST_Point(first(y1),first(x1)),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95') as from_point,
  ST_SetSRID(ST_Point(first(y1), first(x1)),21781) as from_point,
--  ST_Fineltra(ST_SetSRID(ST_Point(last(y1),last(x1)),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95') as to_point,
  ST_SetSRID(ST_Point(last(y1), first(x1)),21781) as to_point,
--  ST_Fineltra(St_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(y1::varchar||' '||x1::varchar||' '||coalesce(z1,0)::varchar, ',' ORDER BY seq)||')'),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95') AS geometry
  ST_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(y1::varchar||' '||x1::varchar||' '||coalesce(z1,0)::varchar, ',' ORDER BY seq)||')'),21781) as geometry
FROM sa.aw_netzlinie_geo
GROUP BY gid)
*/

INSERT INTO qgep_od.vw_qgep_wastewater_structure
 (
  -- wastewater structure
  accessibility,
  identifier,
  remark,
  status,
  structure_condition,
  year_of_construction,
  fk_owner,
  ws_type,
  pully_id_topobase,
  pully_table_topobase,
  pully_db_topobase,
  pully_validation,
  -- cover
  co_shape,
  co_diameter,
  co_fastening,
  co_level,
  co_material,
  co_pully_id_topobase,
  co_pully_table_topobase,
  co_pully_db_topobase,
  --co_identifier, takes ws identifier as default
  co_remark,
  co_positional_accuracy,
  --node
  wn_bottom_level,
  wn_pully_fk_positional_accuracy,
  --wn_identifier, takes ws identifier as default
  wn_pully_node_type,
  wn_pully_orientation,
  wn_pully_id_topobase,
  wn_pully_table_topobase,
  wn_pully_db_topobase,
  --manhole
  ma_dimension1,
  ma_dimension2,
  ma_function,
  ma_material,
  --special_structure
  ss_function,
  --discharge_point
  --infiltration_installation
  situation_geometry
)

SELECT
  -- wastewater structure
  acc.new, -- accessibility
  schacht.fid, -- identifier MUST BE REPLACED BY NAME AFTER TOPOLOGY UPDATE
  schacht.bemerkung, --substr(schacht.bemerkung, 1, 80), -- remark on structure
  st.new, -- status
  stc.new, -- structure condition
  schacht.baujahr, -- construction year
  schacht.id_eigentumsverhaeltnis, -- owner
  COALESCE(st_type.new,'manhole'),
  schacht.fid,
  'AW_SCHACHT',
  'PULLY_ASS',
  true,
  --cover
  co_s.new,  -- shape
  deckel.deckel_dn, -- diameter
  co_f.new, -- fastening
  deckel_geo.z1, -- level
  co_m.new, -- material
  deckel.fid,
  'AW_SCHACHT_DECKEL',
  'PULLY_ASS',
  --deckel.fid, --identifier
  deckel.bemerkung, --substr(deckel.bemerkung, 1, 80), -- remark on cover
  coalesce(co_pa.new,15379),
  --node
  sohle_geo.z1,
  coalesce(wn_pa.new,ws_pa.new,14778),
  --sohle.fid,
  10001,
  round(coalesce(sohle_geo.orientation,schacht_geo.orientation,100)/400*360,2),
  sohle.fid,
  'AW_SCHACHT_SOHLE',
  'PULLY_ASS',
  --manhole
  schacht.dn, -- diameter nominal
  schacht.breite, -- width
  mf.new, --function
  mm.new, --material
  --special structure
  sf.new, --function
  --discharge point
  --infiltration installation
  ST_SetSRID(ST_MakePoint( schacht_geo.y1, schacht_geo.x1, coalesce(schacht_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM migration.schacht schacht -- Manhole
LEFT JOIN migration.schacht_geo schacht_geo ON schacht_geo.gid = schacht.gid -- Manhole Geom
-- Cover / geom
LEFT JOIN migration.schacht_deckel deckel ON schacht.fid = deckel.fid_schacht
LEFT JOIN migration.schacht_deckel_geo deckel_geo ON deckel_geo.gid = deckel.gid
--Bottom / geom
LEFT JOIN migration.schacht_sohle sohle ON schacht.fid = sohle.fid_schacht
LEFT JOIN migration.schacht_sohle_geo sohle_geo ON sohle_geo.gid = sohle.gid
-- Wastewater structure
-- Accessibility
LEFT JOIN migration.map_accessibility acc ON schacht.id_zugaenglichkeit = acc.old
-- Manhole function
LEFT JOIN migration.map_manhole_function mf ON schacht.id_schachtart = mf.old
-- Special structure function
LEFT JOIN migration.map_special_structure_function stf ON schacht.id_schachtart = stf.old
-- Status
LEFT JOIN migration.map_status st ON schacht.id_status = st.old
-- Structure condition (old default)
LEFT JOIN migration.map_structure_condition stc ON schacht.id_defaut = stc.old
-- Cover
-- Shape
LEFT JOIN migration.map_cover_shape co_s ON deckel.id_deckel_form = co_s.old
-- Fastening
LEFT JOIN migration.map_cover_fastening co_f ON deckel.id_deckel_form = co_f.old
-- Material
LEFT JOIN migration.map_cover_material co_m ON deckel.id_material = co_m.old
-- Schacht Positioning
LEFT JOIN migration.map_node_positional_accuracy ws_pa ON schacht.id_lagegenauigkeit = ws_pa.old
-- Cover Positioning
LEFT JOIN migration.map_cover_positional_accuracy co_pa  ON deckel.id_lagegenauigkeit = co_pa.old
-- Node Positioning
LEFT JOIN migration.map_node_positional_accuracy wn_pa ON sohle.id_lagegenauigkeit = wn_pa.old
-- Manhole
-- Material
LEFT JOIN migration.map_manhole_material mm ON schacht.id_material = mm.old
-- Special structure
LEFT JOIN migration.map_special_structure_function sf ON schacht.id_schachtart = sf.old
-- Type
LEFT JOIN migration.map_structure_type st_type ON schacht.id_schachtart = st_type.old
-- Filter deleted items has been done earlier with FME
--WHERE COALESCE(deckel.deleted, 0) = 0 AND COALESCE(schacht.deleted, 0) = 0;
WHERE ST_SetSRID(ST_MakePoint( schacht_geo.y1, schacht_geo.x1, coalesce(schacht_geo.z1,0)),21781)::geometry(PointZ, 21781)IS NOT NULL
--AND deckel.fid IN (SELECT distinct on (fid_schacht ) fid FROM migration.schacht_deckel deckel ORDER by fid_schacht)
--AND sohle.fid IN (SELECT distinct on (fid_schacht ) fid FROM migration.schacht_sohle sohle ORDER by fid_schacht)
AND schacht.id_status != 3
;

-------------------------
-- ACCESS AID
-------------------------
INSERT INTO qgep_od.vw_access_aid(
  kind,
  fk_wastewater_structure
)
SELECT ak.new, ws.obj_id
FROM migration.schacht schacht
LEFT JOIN migration.map_access_aid_kind ak ON ak.old = schacht.id_einstieghilfe
LEFT JOIN qgep_od.wastewater_structure ws ON schacht.fid::text = ws.identifier
WHERE id_einstieghilfe IS NOT NULL;

-------------------------
-- BACKFLOW PREVENTION
-------------------------
INSERT INTO qgep_od.vw_backflow_prevention(
  kind,
  fk_wastewater_structure
)
SELECT 5757, ws.obj_id -- 5757: backflow_flap
FROM migration.schacht schacht
LEFT JOIN qgep_od.wastewater_structure ws ON schacht.fid::text = ws.identifier
WHERE id_schachtart = 10006;

-------------------------
-- 
-------------------------

INSERT INTO qgep_od.vw_wastewater_node
(
identifier,
remark,
pully_node_type,
bottom_level,
pully_orientation,
situation_geometry
)

SELECT
schacht.fid,
art.value,
mnt.new,
coalesce(schacht_geo.z1,sohle_geo.z1,0),
round(coalesce(sohle_geo.orientation,schacht_geo.orientation,0.0)/400.0*360.0 + 90.0,2),
ST_SetSRID(ST_MakePoint( coalesce(sohle_geo.y1,schacht_geo.y1,0), coalesce(sohle_geo.x1,schacht_geo.x1,0), coalesce(sohle_geo.z1,schacht_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM migration.schacht schacht
LEFT JOIN migration.schacht_geo schacht_geo ON schacht_geo.gid = schacht.gid
LEFT JOIN migration.schacht_sohle sohle ON schacht.fid = sohle.fid_schacht
LEFT JOIN migration.schacht_sohle_geo sohle_geo ON sohle_geo.gid = sohle.gid
LEFT JOIN pully_ass.aw_schacht_art_tbd art ON schacht.id_schachtart = art.id
LEFT JOIN migration.map_node_type mnt ON schacht.id_schachtart = mnt.old
WHERE schacht.id_status = 3
AND ST_SetSRID(ST_MakePoint( coalesce(sohle_geo.y1,schacht_geo.y1,0), coalesce(sohle_geo.x1,schacht_geo.x1,0), coalesce(sohle_geo.z1,schacht_geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL;


/* Insertion des systèmes d'évacuation (Raccordements privés)*/

INSERT INTO qgep_od.vw_wastewater_node
(
identifier,
pully_node_type,
pully_se_type,
bottom_level,
pully_orientation,
situation_geometry
)

SELECT
concat('SE ',evac.fid),
10009,
mst.new,
coalesce(evac_geo.z1,0),
round(coalesce(evac_geo.orientation,0.0)/400.0*360.0+90.0,2),
ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM pully_ass.se_point_evac evac
LEFT JOIN pully_ass.se_point_evac_geo evac_geo ON evac_geo.gid = evac.gid
LEFT JOIN migration.map_se_type mst ON evac.types = mst.old
WHERE ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL 
AND mst.new NOT IN (10110,10102,10103,10107,10108);

/* Insertion des Raccordements dans wn raccordement */

INSERT INTO qgep_od.vw_wastewater_node
(
identifier,
pully_node_type,
bottom_level,
pully_orientation,
situation_geometry
)

SELECT
concat('SE ',evac.fid),
10008,
coalesce(evac_geo.z1,0),
round(coalesce(evac_geo.orientation,0.0)/400.0*360.0+90.0,2),
ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM pully_ass.se_point_evac evac
LEFT JOIN pully_ass.se_point_evac_geo evac_geo ON evac_geo.gid = evac.gid
LEFT JOIN migration.map_se_type mst ON evac.types = mst.old
WHERE ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND mst.new IN (10107);

/* Insertion des chambres standard issues de SE Evac*/

INSERT INTO qgep_od.vw_qgep_wastewater_structure
 (
  -- wastewater structure
  identifier,
  status,
  structure_condition,
  fk_owner,
  ws_type,
  pully_id_topobase,
  pully_table_topobase,
  pully_db_topobase,
  --node
  wn_bottom_level,
  --wn_identifier, takes ws identifier as default
  wn_pully_node_type,
  wn_pully_orientation,
  ma_function,
  ma_material,
  --infiltration_installation
  situation_geometry
)

SELECT
concat('SE ',evac.fid),
8493, -- en service
3362, -- aucun defaut
2, -- prive
'manhole',
evac.fid, --fid
'SE_POINT_EVAC',
'PULLY_ASS',
coalesce(evac_geo.z1,0),
10001, --radier
round(coalesce(evac_geo.orientation,0.0)/400.0*360.0+90.0,2),
204, --regard de visite
4541, --materiau
ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM pully_ass.se_point_evac evac
LEFT JOIN pully_ass.se_point_evac_geo evac_geo ON evac_geo.gid = evac.gid
LEFT JOIN migration.map_se_type mst ON evac.types = mst.old
WHERE ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND mst.new IN (10110);

/* Insertion des separateurs issues de SE Evac*/

INSERT INTO qgep_od.vw_qgep_wastewater_structure
 (
  -- wastewater structure
  identifier,
  status,
  structure_condition,
  fk_owner,
  ws_type,
  pully_id_topobase,
  pully_table_topobase,
  pully_db_topobase,
  --node
  wn_bottom_level,
  --wn_identifier, takes ws identifier as default
  wn_pully_node_type,
  wn_pully_orientation,
  ma_function,
  ma_material,
  --infiltration_installation
  situation_geometry
)

SELECT
concat('SE ',evac.fid),
8493, -- en service
3362, -- aucun defaut
2, -- prive
'manhole',
evac.fid, --fid
'SE_POINT_EVAC',
'PULLY_ASS',
coalesce(evac_geo.z1,0),
10001, --radier
round(coalesce(evac_geo.orientation,0.0)/400.0*360.0+90.0,2),
1008, --separateur d'hydrocarbures
4541, --materiau
ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM pully_ass.se_point_evac evac
LEFT JOIN pully_ass.se_point_evac_geo evac_geo ON evac_geo.gid = evac.gid
LEFT JOIN migration.map_se_type mst ON evac.types = mst.old
WHERE ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND mst.new IN (10108);

/* Insertion des cheneaux issues de SE Evac*/

INSERT INTO qgep_od.vw_qgep_wastewater_structure
 (
  -- wastewater structure
  identifier,
  status,
  structure_condition,
  fk_owner,
  ws_type,
  pully_id_topobase,
  pully_table_topobase,
  pully_db_topobase,
  --node
  wn_bottom_level,
  --wn_identifier, takes ws identifier as default
  wn_pully_node_type,
  wn_pully_orientation,
  ma_function,
  ma_material,
  --infiltration_installation
  situation_geometry
)

SELECT
concat('SE ',evac.fid),
8493, -- en service
3362, -- aucun defaut
2, -- prive
'manhole',
evac.fid, --fid
'SE_POINT_EVAC',
'PULLY_ASS',
coalesce(evac_geo.z1,0),
10001, --radier
round(coalesce(evac_geo.orientation,0.0)/400.0*360.0+90.0,2),
3267, --chambre de récolte des eaux de toiture
4541, --materiau
ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM pully_ass.se_point_evac evac
LEFT JOIN pully_ass.se_point_evac_geo evac_geo ON evac_geo.gid = evac.gid
LEFT JOIN migration.map_se_type mst ON evac.types = mst.old
WHERE ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND mst.new IN (10103);

/* Insertion des  issues de SE Evac*/

INSERT INTO qgep_od.vw_qgep_wastewater_structure
 (
  -- wastewater structure
  identifier,
  status,
  structure_condition,
  fk_owner,
  ws_type,
  pully_id_topobase,
  pully_table_topobase,
  pully_db_topobase,
  --node
  wn_bottom_level,
  --wn_identifier, takes ws identifier as default
  wn_pully_node_type,
  wn_pully_orientation,
  ma_function,
  ma_material,
  --infiltration_installation
  situation_geometry
)

SELECT
concat('SE ',evac.fid),
8493, -- en service
3362, -- aucun defaut
2, -- prive
'manhole',
evac.fid, --fid
'SE_POINT_EVAC',
'PULLY_ASS',
coalesce(evac_geo.z1,0),
10001, --radier
round(coalesce(evac_geo.orientation,0.0)/400.0*360.0+90.0,2),
3266, --chambre avec grille d'entrée
4541, --materiau
ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781)

FROM pully_ass.se_point_evac evac
LEFT JOIN pully_ass.se_point_evac_geo evac_geo ON evac_geo.gid = evac.gid
LEFT JOIN migration.map_se_type mst ON evac.types = mst.old
WHERE ST_SetSRID(ST_MakePoint( coalesce(evac_geo.y1,0), coalesce(evac_geo.x1,0), coalesce(evac_geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND mst.new IN (10102);

-------------------------
-- Surfacic wastewaterstructure
-------------------------
/*
UPDATE qgep_od.wastewater_structure ws
SET detail_geometry_geometry = (SELECT st_force3d(st_forcecurve(the_geom))::geometry(curvepolygonz,21781))
FROM pully_ass_spatial.aw_schachtdetail
WHERE aw_schachtdetail.fid_schacht::text = ws.identifier
AND st_geometrytype(the_geom)::text = 'ST_Polygon'
AND deleted = 0
*/
/* Remplacé par FME
With schachtdetail_geo AS (
SELECT
  detail.gid,
  detail.fid_schacht,
  ST_MakePolygon(ST_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(geo.y1::varchar||' '||geo.x1::varchar||' '||coalesce(geo.z1,0)::varchar, ',' ORDER BY seq)||')'), 21781)) AS geometry
FROM sa.aw_schachtdetail detail
LEFT JOIN sa.aw_schachtdetail_geo geo ON detail.gid = geo.gid
GROUP BY detail.gid,detail.fid_schacht
HAVING count(z1)>3 AND ST_IsClosed(ST_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(geo.y1::varchar||' '||geo.x1::varchar||' '||coalesce(geo.z1,0)::varchar, ',' ORDER BY seq)||')'), 21781)) = True
)
UPDATE qgep.od_wastewater_structure AS ws
SET detail_geometry_geometry = schachtdetail_geo.geometry
FROM schachtdetail_geo
WHERE ws.identifier = schachtdetail_geo.fid_schacht::text;
*/

------------------------
-- Update Covers geometries
------------------------

UPDATE qgep_od.vw_cover
SET
  situation_geometry = selection.cover_geometry
FROM
(SELECT
  deckel.fid as cover_fid,
  ST_SetSRID(ST_MakePoint( deckel_geo.y1, deckel_geo.x1, coalesce(deckel_geo.z1,0)),21781)::geometry(PointZ, 21781) as cover_geometry

FROM migration.schacht_deckel deckel
LEFT JOIN migration.schacht_deckel_geo deckel_geo ON deckel_geo.gid = deckel.gid
) as selection

WHERE pully_id_topobase = selection.cover_fid::character varying
AND selection.cover_geometry IS NOT NULL;

------------------------
-- Update Nodes geometries
------------------------

UPDATE qgep_od.vw_wastewater_node
SET
  situation_geometry = selection.node_geometry
FROM
(SELECT
  sohle.fid as node_fid,
  ST_SetSRID(ST_MakePoint( sohle_geo.y1, sohle_geo.x1, coalesce(sohle_geo.z1,0)),21781)::geometry(PointZ, 21781) as node_geometry

FROM migration.schacht_sohle sohle
LEFT JOIN migration.schacht_sohle_geo sohle_geo ON sohle_geo.gid = sohle.gid
) as selection

WHERE pully_id_topobase = selection.node_fid::character varying
AND selection.node_geometry IS NOT NULL;

