select count(*), id_profilart, round(NULLIF(profil_hoehe, 0)/profil_breite, 2) as ratio, pa.value, 
CASE WHEN pa.id=1 THEN 5377
     WHEN pa.id=2 THEN 3350
     WHEN pa.id=3 THEN 3353
     WHEN pa.id=4 THEN 5377
     WHEN pa.id=5 THEN 3357
     WHEN pa.id=6 THEN 3351
     WHEN pa.id=7 THEN 3353
END AS profile_code,
CONCAT(pa.value, ' ', round(NULLIF(profil_hoehe, 0)/profil_breite, 2)) AS identifier
from sa.aw_haltung ha
LEFT JOIN sa.aw_profilart_tbd pa ON pa.id = ha.id_profilart
LEFT JOIN qgep.vl_pipe_profile_profile_type pp ON pp.value_fr = pa.value
group by id_profilart, ratio, pa.value, pp.code, pa.id
order by id_profilart