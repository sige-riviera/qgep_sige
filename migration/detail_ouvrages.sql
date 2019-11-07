--Update detail wastewater structure

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

--Update detailed wastwater structures

UPDATE qgep_od.wastewater_structure
SET detail_geometry_geometry = ST_Force3D(ST_Multi(selection.geom))
FROM(
SELECT geom,schacht.fid as fid_schacht
FROM pully_ass.aw_schacht schacht
LEFT JOIN pully_ass.aw_sonderbauwerk sbw ON sbw.fid_schacht = schacht.fid
LEFT JOIN pully_ass_spatial.aw_sbwdetail detail ON detail.fid_sonderbauwerk = sbw.fid
WHERE sbw.fid_schacht IS NOT NULL
AND detail.fid_sonderbauwerk IS NOT NULL
AND ST_GeometryType(geom) = 'ST_Polygon') as selection
WHERE selection.fid_schacht::character varying = wastewater_structure.pully_id_topobase;

--Update sbw detail

UPDATE qgep_od.wastewater_structure
SET detail_geometry_geometry = ST_Force3D(ST_Multi(selection.geom))
FROM(
SELECT geom,schacht.fid as fid_schacht
FROM pully_ass.aw_schacht schacht
LEFT JOIN pully_ass.aw_sbw_wehr sbw_w ON sbw_w.s_id = schacht.fid
LEFT JOIN pully_ass_spatial.aw_sbwdetail detail ON detail.fid_sbw_wehr = sbw_w.fid
WHERE sbw_w.s_id IS NOT NULL
AND detail.fid_sbw_wehr IS NOT NULL
AND ST_GeometryType(geom) = 'ST_Polygon') as selection
WHERE selection.fid_schacht::character varying = wastewater_structure.pully_id_topobase;

