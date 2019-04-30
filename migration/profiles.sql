INSERT INTO qgep_od.pipe_profile(profile_type, height_width_ratio, identifier)
SELECT  
CASE WHEN pa.id=1 THEN 3351 -- ovoide
     WHEN pa.id=2 THEN 3350 -- circulaire
     WHEN pa.id=4 THEN 3352 -- profil en voute
     WHEN pa.id=5 THEN 3354 -- profil ouvert
     WHEN pa.id=6 THEN 3353 -- rectangulaire
     WHEN pa.id=7 THEN 3355 -- cunette -> profil special
     WHEN pa.id=8 THEN 3355 -- profil special
     WHEN pa.id=9 THEN 3357 -- inconnu
     WHEN pa.id=10 THEN 3355 -- autre -> profil special?
     WHEN pa.id=100 THEN 3355 -- apparent -> profil special?
     WHEN pa.id=101 THEN 3355 -- perfore -> profil special?
END AS profile_type,
COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1) as ratio,
CONCAT(pa.value, ' ', COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1)) AS identifier
from migration.haltung ha
LEFT JOIN pully_ass.aw_profilart_tbd pa ON pa.id = ha.id_profilart
GROUP BY id_profilart, ratio, pa.value, pa.id, COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1);
