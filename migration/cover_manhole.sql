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

INSERT INTO qgep.vw_qgep_cover
 (
  ws_type,
  identifier,
  bottom_level,
  depth,
  year_of_construction,
  dimension1,
  dimension2,
  year_of_replacement,
  location_name,
  remark,
  ws_remark,
  situation_geometry,
  level,
  manhole_function,
  status,
  ws_identifier
)

SELECT
  'manhole',
  schacht.name2,
  unten_hoehe,
  tiefe,
  baujahr,
  dn,
  breite,
  EXTRACT(YEAR FROM date_rehabil),
  ortsbezeichnung,
  deckel.bemerkung,
  substr(schacht.bemerkung, 1, 80),
  ST_SetSRID(ST_Point( deckel_geo.y1, deckel_geo.x1 ), 21781 ),
  Z1,
  CASE WHEN id_aeration=1 THEN 4533 ELSE mf.new END,
  st.new,
  schacht.fid
FROM sa.aw_schacht_deckel deckel
LEFT JOIN sa.aw_schacht schacht ON deckel.fid_schacht = schacht.fid
LEFT JOIN sa.aw_schacht_deckel_geo deckel_geo ON deckel_geo.gid = deckel.gid
LEFT JOIN sa.map_manhole_function mf ON schacht.id_schachtart = mf.old
LEFT JOIN sa.map_status st ON schacht.id_status = st.old
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
-- FIX ws.identifier
-------------------------

UPDATE qgep.od_wastewater_structure AS ws
SET identifier = schacht.name2
FROM sa.aw_schacht AS schacht
WHERE ws.identifier = schacht.fid::text;
