UPDATE qgep_od.wastewater_structure

SET detail_geometry_geometry = ST_Force3D(ST_Multi(selection.geom))

FROM
(
SELECT
  fid,
  gid,
  deleted,
  area_nominal,
  point_number,
  radius,
  bemerkung,
  id_art,
  id_funktion,
  fid_schacht,
  geom,
  ST_GeometryType(geom),
  'PULLY' AS commune

FROM pully_ass_spatial.aw_schachtdetail
WHERE   ST_GeometryType(geom) = 'ST_Polygon'
	AND fid_schacht IS NOT NULL
	
UNION
SELECT
  fid,
  gid,
  deleted,
  area_nominal,
  point_number,
  radius,
  bemerkung,
  id_art,
  id_funktion,
  fid_schacht,
  geom,
  ST_GeometryType(geom),
  'BELMONT' as commune

FROM belmont_ass_spatial.aw_schachtdetail
WHERE   ST_GeometryType(geom) = 'ST_Polygon'
	AND fid_schacht IS NOT NULL) AS selection
WHERE wastewater_structure.pully_id_topobase = selection.fid_schacht::character varying;
