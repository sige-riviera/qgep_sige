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
  wn_identifier,
  --manhole
  dimension1,
  dimension2,
  manhole_function,
  material,
  --special_structure
  special_structure_function,
  --discharge_point
  --infiltration_installation
  situation_geometry
)

SELECT
  -- wastewater structure
  acc.new, -- accessibility
  schacht.fid, -- identifier
  schacht.bemerkung, --substr(schacht.bemerkung, 1, 80), -- remark on structure
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
  deckel.bemerkung, --substr(deckel.bemerkung, 1, 80), -- remark on cover
  --node
  sohle_geo.z1,
  schacht.fid,
  --manhole
  schacht.dn, -- diameter nominal
  schacht.breite, -- width
  mf.new, --function
  mm.new, --material
  --special structure
  sf.new, --function
  --discharge point
  --infiltration installation
  ST_Multi(ST_SetSRID(ST_MakePoint( schacht_geo.y1, schacht_geo.x1),21781))::geometry(MultiPoint, 21781)

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
-- Cover
-- Shape
LEFT JOIN sa.map_cover_shape co_s ON deckel.id_deckel_form = co_s.old
-- Fastening
LEFT JOIN sa.map_cover_fastening co_f ON deckel.id_deckel_form = co_f.old
-- Material
LEFT JOIN sa.map_cover_material co_m ON deckel.id_material = co_m.old
-- Horizontal positioning
--LEFT JOIN sa.map_horizontal_positioning hp ON deckel.id_lagegenauigkeit = hp.old
-- Manhole
-- Material
LEFT JOIN sa.map_manhole_material mm ON schacht.id_material = mm.old
-- Special structure
LEFT JOIN sa.map_special_structure_function sf ON schacht.id_schachtart = sf.old
-- Owner
LEFT JOIN sa.ba_eigentumsverhaeltnis_tbd ev ON ev.id = schacht.id_eigentumsverhaeltnis
-- Organisation
LEFT JOIN qgep.od_organisation org ON org.identifier = ev.value
-- Type
LEFT JOIN sa.map_structure_type st_type ON schacht.id_schachtart = st_type.old
-- Filter deleted items
WHERE COALESCE(deckel.deleted, 0) = 0 AND COALESCE(schacht.deleted, 0) = 0;

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
-- Update wastewaterstructure_identifier
------------------------

/*
To uncomment and run for final migration
UPDATE qgep.od_wastewater_structure AS ws
SET identifier = schacht.name
FROM sa.aw_schacht AS schacht
WHERE ws.identifier = schacht.fid::text;
*/
