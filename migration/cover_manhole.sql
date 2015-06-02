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
  level
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
  Z1
FROM sa.aw_schacht_deckel deckel
LEFT JOIN sa.aw_schacht schacht ON deckel.fid_schacht = schacht.fid
LEFT JOIN sa.aw_schacht_deckel_geo deckel_geo ON deckel_geo.fid = deckel.fid
WHERE deckel.deleted IS NOT NULL AND schacht.deleted IS NOT NULL
