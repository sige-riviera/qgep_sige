
-- compute geometry from aw_haltung_geo
select gid, St_SetSRID(ST_GeomFromText('LINESTRING('||string_agg(y1::varchar||' '||x1::varchar, ',' order by seq)||')'),21781) as geometry from sige_assainissement.aw_haltung_geo group by gid;
