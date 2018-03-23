-- insert catchment area 

INSERT INTO qgep.od_catchment_area(
  identifier,
  discharge_coefficient_ww_current,
  perimeter_geometry
)
SELECT
  fid,
  psi_wert,
  ST_SETSRID(ST_GEOMFROMTEXT('CURVEPOLYGON('||st_astext(the_geom)::text ||')'),21781)::geometry(CurvePolygon,21781)

FROM sas.aw_teileinzugsgebiet bv
