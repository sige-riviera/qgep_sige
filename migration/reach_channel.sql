-- compute geometry from aw_haltung_geo
WITH haltung_geo AS (SELECT gid, St_SetSRID(ST_GeomFromText('LINESTRING('||string_agg(y1::varchar||' '||x1::varchar, ',' ORDER BY seq)||')'),21781) AS geometry FROM sa.aw_haltung_geo GROUP BY gid)

INSERT INTO qgep.vw_qgep_reach(
  identifier,
  remark,
  length_effective, -- == haltungslaenge oder stranglaenge?
  year_of_construction,
  slope_per_mill, -- == gefaelle?
  progression_geometry,
  function_hierarchic
)
SELECT
  name2,
  bemerkung,
  haltungslaenge,
  baujahr,
  gefaelle,
  geometry,
  fh.new
  
FROM sa.aw_haltung haltung
LEFT JOIN haltung_geo geom on geom.gid = haltung.fid
LEFT JOIN sa.map_function_hierarchic fh ON haltung.id_funktion_hierarch = fh.old
WHERE haltung.deleted <> 1;