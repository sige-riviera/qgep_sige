-- INSERT INTO qgep.vw_cover
-- (identifier,
--  bottom_level,
--  depth,
--  year_of_contsruction,
--  dimension1,
--  dimension2,
--  year_of_replacement,
--  location_name,
--  remark,
--  node_geometry,
--  level
-- (

-- VALUES(
--  schacht.name2,
--  unten_hoehe,
--  tiefe,
--  baujahr,
--  dn,
--  breite,
--  date_rehabil,
--  ortsbezeichnung,
--  bemerkung,
--  geometry,
--  Z1
-- )

SELECT * FROM sa.aw_schacht_deckel deckel
LEFT JOIN sa.aw_schact schacht ON deckel.fid_schacht = schacht.fid
WHERE deckel.deleted IS NOT NULL AND schacht.deleted IS NOT NULL