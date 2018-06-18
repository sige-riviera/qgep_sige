WITH netzlinien AS (
SELECT
  gid,
--  ST_Fineltra(ST_SetSRID(ST_Point(first(y1),first(x1)),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95')::Geometry(Point,2056) as from_point,
  ST_SetSRID(ST_Point(first(y1),first(x1)), 21781) as from_point,
--  ST_Fineltra(ST_SetSRID(ST_Point(last(y1),last(x1)),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95')::Geometry(Point,2056) as to_point,
  ST_SetSRID(ST_Point(last(y1),last(x1)), 21781) as to_point,
--  ST_Fineltra(St_SetSRID(ST_GeomFromText('LINESTRING('||string_agg(y1::varchar||' '||x1::varchar, ',' ORDER BY seq)||')'),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95')::Geometry(Linestring,2056) AS geometry
  ST_SetSRID(ST_GeomFromText('LINESTRING('||string_agg(y1::varchar||' '||x1::varchar, ',' ORDER BY seq)||')'), 21781) as geometry
FROM migration.netzlinie_geo
GROUP BY gid)

INSERT INTO qgep_od.vw_overflow_prank_weir ( 
  identifier,
  fk_wastewater_node,
  fk_overflow_to
  )
SELECT
  schacht.name2 AS ws_identifier,
  wn_from.obj_id AS wn_from_obj_id,
  wn_to.obj_id AS wn_to_obj_id
FROM
migration.schacht
LEFT JOIN qgep_od.vw_wastewater_node wn_from ON identifier = name2
LEFT JOIN netzlinien ON from_point = wn_from.situation_geometry
LEFT JOIN qgep_od.vw_wastewater_node wn_to ON to_point=wn_to.situation_geometry
WHERE id_schachtart = 10003 OR id_schachtart = 10002 OR id_schachtart = 24;

--Deleted items are removed at export
--AND COALESCE(deleted, 0) <> 0;
