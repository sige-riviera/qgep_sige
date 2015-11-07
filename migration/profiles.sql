INSERT INTO qgep.od_pipe_profile(profile_type, height_width_ratio, identifier)
SELECT  
CASE WHEN pa.id=1 THEN 3357
     WHEN pa.id=2 THEN 3350
     WHEN pa.id=3 THEN 3353
     WHEN pa.id=4 THEN 3357
     WHEN pa.id=5 THEN 3357
     WHEN pa.id=6 THEN 3351
     WHEN pa.id=7 THEN 3353
END AS profile_type,
COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1) as ratio,
CONCAT(pa.value, ' ', COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1)) AS identifier
from sa.aw_haltung ha
LEFT JOIN sa.aw_profilart_tbd pa ON pa.id = ha.id_profilart
GROUP BY id_profilart, ratio, pa.value, pa.id, COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1)


