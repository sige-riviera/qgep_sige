-- compute geometry from aw_leitungen_geo
WITH anchslussleitungen_geo AS (
SELECT
  gid,
  first(z1) as rp_from_level,
  last(z1) as rp_to_level,
--  ST_Fineltra(St_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(y1::varchar||' '||x1::varchar||' '||coalesce(z1,0)::varchar, ',' ORDER BY seq)||')'),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95')::Geometry(LinestringZ,2056) AS geometry 
  ST_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(y1::varchar||' '||x1::varchar||' '||coalesce(z1,0)::varchar, ',' ORDER BY seq)||')'), 21781) AS geometry
FROM sa.aw_anschlussleitung_geo
GROUP BY gid)

INSERT INTO qgep.vw_qgep_reach(
  identifier,
  remark,
--  length_effective, -- == haltungslaenge oder stranglaenge?
  year_of_construction,
 -- slope_per_mill, -- == gefaelle?
  progression_geometry,
  function_hierarchic,
  horizontal_positioning,
  clear_height,
  fk_pipe_profile,
  usage_current,
  material,
  function_hydraulic,
  elevation_determination,
 -- rp_from_level,
 -- rp_to_level,
  fk_owner,
  structure_condition
)
SELECT
  anschluss.name2,
  substr(bemerkung,1,80),
 -- ST_3dLength(geometry),
  baujahr,
 -- gefaelle,
  ST_ForceCurve(geometry),
  fh.new, --hydraulic function
  COALESCE(hp.new, 5379), --horizontal positionning,
  NULLIF(COALESCE(profil_hoehe, profil_breite), 0),
  pp.obj_id,
  uc.new,
  rm.new,
  fhy.new,
  ed.new,
  --rp_from_level,
  --rp_to_level,
  org.obj_id,
  3037

FROM sa.aw_anschlussleitung as anschluss
LEFT JOIN anchslussleitungen_geo geom on geom.gid = anschluss.gid
LEFT JOIN sa.map_function_hierarchic_leitungen fh ON anschluss.id_funktion_hierarch = fh.old OR (fh.old IS NULL AND anschluss.id_funktion_hierarch IS NULL)
LEFT JOIN sa.map_horizontal_positioning hp ON anschluss.id_lagegenauigkeit = hp.old
LEFT JOIN sa.map_usage_current uc ON anschluss.id_nutzungs_art = uc.old
LEFT JOIN sa.aw_profilart_tbd pa ON pa.id = anschluss.id_profilart

-- Join the profile based on it's type and the height/width-ratio
-- This code has to match the code in profiles.sql
LEFT JOIN qgep.od_pipe_profile pp ON pp.profile_type =
  CASE WHEN pa.id=1 THEN 5377
     WHEN pa.id=2 THEN 3350
     WHEN pa.id=3 THEN 3353
     WHEN pa.id=4 THEN 5377
     WHEN pa.id=5 THEN 3357
     WHEN pa.id=6 THEN 3351
     WHEN pa.id=7 THEN 3353
  END
  AND pp.height_width_ratio = COALESCE(round(NULLIF(anschluss.profil_hoehe, 0)/anschluss.profil_breite, 2),1)

LEFT JOIN sa.map_reach_material rm ON anschluss.id_material = rm.old
LEFT JOIN sa.map_function_hydraulic fhy ON anschluss.id_funktion_hydrau = fhy.old
LEFT JOIN sa.map_elevation_determination ed ON anschluss.id_hoehengenauigkeit = ed.old
LEFT JOIN sa.ba_eigentumsverhaeltnis_tbd ev ON ev.id = anschluss.id_eigentumsverhaeltnis
LEFT JOIN qgep.od_organisation org ON org.identifier = ev.value

WHERE COALESCE(anschluss.deleted, 0) = 0;
