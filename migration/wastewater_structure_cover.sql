/***************************************************************************
    TopoBase2 to QGEP migration script for
     * Covers
     * Manholes
     * Access Aids
     --------------------------------------
    Date                 : 1.6.2015
    Copyright            : (C) 2015 Matthias Kuhn
    Email                : matthias at opengis dot ch
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

INSERT INTO qgep.vw_qgep_wastewater_structure
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
  -- cover
  cover_shape,
  diameter,
  fastening,
  level,
  cover_material,
--  positional_accuracy,
  co_identifier,
  co_remark,
  --node
  bottom_level,
  --manhole
  dimension1,
  dimension2,
  -- year_of_replacement,
  situation_geometry,
  manhole_function,
  special_structure_function
)

SELECT
  -- wastewater structure
  acc.new, -- accessibility
  substr(schacht.name,1,20), -- identifier
  substr(schacht.bemerkung, 1, 80), -- remark on structure
  st.new, -- status
  stc.new, -- structure condition
  schacht.baujahr, -- construction year
  org.obj_id, -- owner
  COALESCE(st_type.new,'manhole'),
  --cover
  co_s.new,  -- shape
  deckel.deckel_dn, -- diameter
  co_f.new, -- fastening
  deckel_geo.z1, -- level
  co_m.new, -- material
--  hp.new, -- horizontal positionning
  deckel.name, --identifier
  substr(deckel.bemerkung, 1, 80), -- remark on cover
  --node
  schacht.unten_hoehe,
  --manhole
  schacht.dn, -- diameter nominal
  schacht.breite, -- width
  --EXTRACT(YEAR FROM date_rehabil),
  --ST_Force2d(ST_Fineltra( ST_SetSRID(ST_MakePoint( deckel_geo.y1, deckel_geo.x1, deckel_geo.z1 ), 21781 ), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95')),
  ST_Multi(ST_SetSRID(ST_MakePoint( schacht_geo.y1, schacht_geo.x1),21781))::geometry(MultiPoint, 21781),
  --CASE WHEN id_aeration=1 THEN 4533 ELSE mf.new END,
  mf.new,
  stf.new

FROM sa.aw_schacht schacht -- Manhole
LEFT JOIN sa.aw_schacht_geo schacht_geo ON schacht_geo.gid = schacht.gid -- Manhole Geom
-- Cover / geom
LEFT JOIN sa.aw_schacht_deckel deckel ON schacht.fid = deckel.fid_schacht
LEFT JOIN sa.aw_schacht_deckel_geo deckel_geo ON deckel_geo.gid = deckel.gid
--Bottom / geom
LEFT JOIN sa.aw_schacht_sohle sohle ON schacht.fid = sohle.fid_schacht
LEFT JOIN sa.aw_schacht_sohle_geo sohle_geo ON sohle_geo.gid = sohle.gid
-- Wastewater structure
-- Accessibility
LEFT JOIN sa.map_accessibility acc ON schacht.id_zugaenglichkeit = acc.old
-- Manhole function
LEFT JOIN sa.map_manhole_function mf ON schacht.id_schachtart = mf.old
-- Special structure function
LEFT JOIN sa.map_special_structure_function stf ON schacht.id_schachtart = stf.old
-- Status
LEFT JOIN sa.map_status st ON schacht.id_status = st.old
-- Structure condition (old default)
LEFT JOIN sa.map_structure_condition stc ON schacht.id_defaut = stc.old
-- Cover shape
LEFT JOIN sa.map_cover_shape co_s ON deckel.id_deckel_form = co_s.old
-- Cover fastening
LEFT JOIN sa.map_cover_fastening co_f ON deckel.id_deckel_form = co_f.old
-- Cover material
LEFT JOIN sa.map_cover_material co_m ON deckel.id_material = co_m.old
-- Cover horizontal positioning
--LEFT JOIN sa.map_horizontal_positioning hp ON deckel.id_lagegenauigkeit = hp.old
-- ??
LEFT JOIN sa.ba_eigentumsverhaeltnis_tbd ev ON ev.id = schacht.id_eigentumsverhaeltnis
-- Organisation
LEFT JOIN qgep.od_organisation org ON org.identifier = ev.value
-- Type
LEFT JOIN sa.map_structure_type st_type ON schacht.id_schachtart = st_type.old
-- Filter deleted items
WHERE COALESCE(deckel.deleted, 0) = 0 AND COALESCE(schacht.deleted, 0) = 0;

-------------------------
-- Update COVERS
-------------------------

--Update covers geometries

UPDATE qgep.od_wastewater_structure AS ws
SET identifier = schacht.name2
FROM sa.aw_schacht AS schacht
WHERE ws.identifier = schacht.fid::text;

-------------------------
-- ACCESS AID
-------------------------
INSERT INTO qgep.vw_access_aid(
  kind,
  fk_wastewater_structure
)
SELECT ak.new, ws.obj_id
FROM sa.aw_schacht schacht
LEFT JOIN sa.map_access_aid_kind ak ON ak.old = schacht.id_einstieghilfe
LEFT JOIN qgep.od_wastewater_structure ws ON schacht.fid::text = ws.identifier
WHERE id_einstieghilfe IS NOT NULL;

-------------------------
-- BACKFLOW PREVENTION
-------------------------
INSERT INTO qgep.vw_backflow_prevention(
  kind,
  fk_wastewater_structure
)
SELECT 5757, ws.obj_id -- 5757: backflow_flap
FROM sa.aw_schacht schacht
LEFT JOIN qgep.od_wastewater_structure ws ON schacht.fid::text = ws.identifier
WHERE id_schachtart = 10006;

-------------------------
-- overflows
-------------------------


-------------------------
-- Surfacic wastewaterstructure
-------------------------



-------------------------
-- FIX ws.identifier
-------------------------

UPDATE qgep.od_wastewater_structure AS ws
SET identifier = schacht.name2
FROM sa.aw_schacht AS schacht
WHERE ws.identifier = schacht.fid::text;
