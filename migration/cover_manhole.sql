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
  status
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
  st.new
FROM sa.aw_schacht_deckel deckel
LEFT JOIN sa.aw_schacht schacht ON deckel.fid_schacht = schacht.fid
LEFT JOIN sa.aw_schacht_deckel_geo deckel_geo ON deckel_geo.fid = deckel.fid
LEFT JOIN sa.map_manhole_function mf ON schacht.id_schachtart = mf.old
LEFT JOIN sa.map_status st ON schacht.id_status = st.old
WHERE deckel.deleted IS NOT NULL AND schacht.deleted IS NOT NULL
