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

-- compute netzlinien

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
  ws_type,
  co_identifier,
  bottom_level,
  _depth,
  year_of_construction,
  dimension1,
  dimension2,
  --year_of_replacement,
  location_name,
  remark,
  ws_remark,
  situation_geometry,
  level,
  manhole_function,
  special_structure_function,
  status,
  identifier,
  fk_owner
)

SELECT
  COALESCE(st_type.new,'manhole'),
  schacht.name2,
  schacht.unten_hoehe,
  tiefe,
  schacht.baujahr, -- construction year
  schacht.dn, -- diameter nominal
  schacht.breite, -- width
  --EXTRACT(YEAR FROM date_rehabil),
  schacht.ortsbezeichnung, -- location name
  substr(deckel.bemerkung, 1, 80), -- remark on cover
  substr(schacht.bemerkung, 1, 80), -- remark on structure
  --ST_Force2d(ST_Fineltra( ST_SetSRID(ST_MakePoint( deckel_geo.y1, deckel_geo.x1, deckel_geo.z1 ), 21781 ), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95')),
  ST_Multi(ST_SetSRID(ST_MakePoint( schacht_geo.y1, schacht_geo.x1),21781))::geometry(MultiPoint, 21781),
  schacht_geo.z1,
  --CASE WHEN id_aeration=1 THEN 4533 ELSE mf.new END,
  mf.new,
  stf.new,
  st.new,
  schacht.fid,
  org.obj_id
  
FROM sa.aw_schacht schacht -- Manhole
LEFT JOIN sa.aw_schacht_geo schacht_geo ON schacht_geo.gid = schacht.gid -- Manhole Geom
-- Cover / geom
LEFT JOIN sa.aw_schacht_deckel deckel ON schacht.fid = deckel.fid_schacht
LEFT JOIN sa.aw_schacht_deckel_geo deckel_geo ON deckel_geo.gid = deckel.gid
--Bottom / geom
LEFT JOIN sa.aw_schacht_sohle sohle ON schacht.fid = sohle.fid_schacht
LEFT JOIN sa.aw_schacht_sohle_geo sohle_geo ON sohle_geo.gid = sohle.gid
-- Manhole function
LEFT JOIN sa.map_manhole_function mf ON schacht.id_schachtart = mf.old
-- Special structure function
LEFT JOIN sa.map_special_structure_function stf ON schacht.id_schachtart = stf.old
-- Status
LEFT JOIN sa.map_status st ON schacht.id_status = st.old
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
