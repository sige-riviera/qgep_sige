-- compute geometry from aw_anschlussleitung_geo

WITH anschlussleitungen_geo AS (
SELECT
  gid,
  first(z1) as rp_from_level,
  last(z1) as rp_to_level,
--  ST_Fineltra(St_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(y1::varchar||' '||x1::varchar||' '||coalesce(z1,0)::varchar, ',' ORDER BY seq)||')'),21781), 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95')::Geometry(LinestringZ,2056) AS geometry 
  ST_SetSRID(ST_GeomFromText('LINESTRINGZ('||string_agg(y1::varchar||' '||x1::varchar||' '||coalesce(z1,0)::varchar, ',' ORDER BY seq)||')'), 21781) AS geometry
FROM sa.aw_anschlussleitung_geo
GROUP BY gid)

INSERT INTO qgep.vw_qgep_reach(
  --Reach
  clear_height,
  width,
  material,
  length_effective,
  slope_per_mill,
  progression_geometry,
  elevation_determination,
  horizontal_positioning,
  fk_pipe_profile,
  --Channel
  function_hierarchic,
  function_hydraulic,
  pipe_length,
  usage_current,
  --Wastewater Structure
  status,
  year_of_construction,
  fk_owner,
  ws_identifier,
  ws_remark,
  --Network element
  ne_identifier,
  --Reach point from
  rp_from_identifier,
  rp_from_level,
  --Reach point to
  rp_to_identifier,
  rp_to_level
  --Active maintenance event
)
SELECT
  --Reach
  profil_hoehe, --clear_height
  profil_breite, -- width
  rml.new, -- material
  ST_3dLength(geometry), -- length_effective
  gefaelle, --slope per mill
  ST_ForceCurve(geometry), -- progression_geometry
  ed.new,
  COALESCE(hp.new, 5379),
  pp.obj_id,
  --Channel
  fhl.new, -- function_hierarchic
  fhyl.new, -- function_hydraulic
  laenge, -- pipe_length
  uc.new, -- usage_current
  --Wastewater Structure
  st.new, -- status
  baujahr, -- year_of_construction
  org.obj_id, -- fk_owner
  anschluss.fid, -- ws_identifier
  bemerkung,--substr(bemerkung, 1, 80),--remark
  --Network element
  anschluss.fid, -- re_identifier
  --(Automatic)
  --Reach point from
  fid_vs,
  rp_from_level,
  --Reach point to
  fid_bs,
  rp_to_level

FROM sa.aw_anschlussleitung anschluss
LEFT JOIN anschlussleitungen_geo geom on geom.gid = anschluss.gid
LEFT JOIN sa.map_function_hierarchic_leitungen fhl ON anschluss.id_funktion_hierarch = fhl.old
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

LEFT JOIN sa.map_reach_material_leitungen rml ON anschluss.id_material = rml.old
LEFT JOIN sa.map_function_hydraulic_leitungen fhyl ON anschluss.id_funktion_hydrau = fhyl.old
LEFT JOIN sa.map_elevation_determination ed ON anschluss.id_hoehengenauigkeit = ed.old
LEFT JOIN sa.map_status st ON anschluss.id_status = st.old
LEFT JOIN sa.ba_eigentumsverhaeltnis_tbd ev ON ev.id = anschluss.id_eigentumsverhaeltnis
LEFT JOIN qgep.od_organisation org ON org.identifier = ev.value

WHERE COALESCE(anschluss.deleted, 0) = 0;
