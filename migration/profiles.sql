INSERT INTO qgep_od.pipe_profile(profile_type, height_width_ratio, identifier)
SELECT
mpt.new as profile_type,
COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1) as ratio,
CONCAT(pt.value_fr, ' ', COALESCE(round(NULLIF(profil_hoehe, 0)/profil_breite, 2), 1)) AS identifier
from migration.haltung ha
LEFT JOIN migration.map_profile_type mpt ON mpt.old = ha.id_profilart
LEFT JOIN qgep_vl.pipe_profile_profile_type pt ON mpt.new = pt.code
GROUP BY mpt.new,pt.value_fr, ratio;
