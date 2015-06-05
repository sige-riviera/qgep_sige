/**
 * Will find the connection of overflows based on the geometry defined in aw_netzlinie_geo.
 * 
 * We will need to create wastewater nodes where the to-node is not yet created and connect that
 * to a reach point (I hope there is one).
 * Unless they are connected to some other wastewater structure which we did not yet take care of.
 * 
 */
CREATE VIEW sa.netzlinien AS

WITH netzlinien AS (
SELECT 
  gid, 
  ST_SetSRID(ST_Point(first(y1),first(x1)),21781) as from_point, 
  ST_SetSRID(ST_Point(last(y1),last(x1)),21781) as to_point, 
  St_SetSRID(ST_GeomFromText('LINESTRING('||string_agg(y1::varchar||' '||x1::varchar, ',' ORDER BY seq)||')'),21781) AS geometry 
FROM sa.aw_netzlinie_geo 
GROUP BY gid)

SELECT 
  aw_schacht.name2 AS ws_identifier,
  wn_from.obj_id AS wn_from_obj_id, 
  wn_to.obj_id AS wn_to_obj_id,
  id_schachtart AS type,
  geometry
FROM 
sa.aw_schacht
LEFT JOIN qgep.vw_wastewater_node wn_from ON identifier = name2
LEFT JOIN netzlinien ON from_point = wn_from.situation_geometry
LEFT JOIN qgep.vw_wastewater_node wn_to ON to_point=wn_to.situation_geometry
WHERE id_schachtart = 10003 OR id_schachtart = 10002 OR id_schachtart = 24