-- Update case
UPDATE pully_ass.aw_haltung
SET p_fichier_1 = REPLACE(p_fichier_1, 'G:\Vidéos collecteurs','G:\Vidéos Collecteurs');
UPDATE pully_ass.aw_haltung
SET p_fichier_2 = REPLACE(p_fichier_2, 'G:\Vidéos collecteurs','G:\Vidéos Collecteurs');
UPDATE pully_ass.aw_haltung
SET p_fichier_3 = REPLACE(p_fichier_3, 'G:\Vidéos collecteurs','G:\Vidéos Collecteurs');
UPDATE pully_ass.aw_haltung
SET p_fichier_4 = REPLACE(p_fichier_4, 'G:\Vidéos collecteurs','G:\Vidéos Collecteurs');

-- Insertion des fichiers des collecteurs Pully

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
re.identifier,
re.obj_id,
3775,
3801,
left(p_fichier_1,200)
from pully_ass.aw_haltung
left join qgep_od.vw_qgep_reach re ON fid::text = re.identifier
where p_fichier_1 is not NULL AND ws_pully_db_topobase = 'PULLY_ASS';

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
re.identifier,
re.obj_id,
3775,
3801,
left(p_fichier_2,200)
from pully_ass.aw_haltung
left join qgep_od.vw_qgep_reach re ON fid::text = re.identifier
where p_fichier_2 is not NULL AND ws_pully_db_topobase = 'PULLY_ASS';

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
re.identifier,
re.obj_id,
3775,
3801,
left(p_fichier_3,200)
from pully_ass.aw_haltung
left join qgep_od.vw_qgep_reach re ON fid::text = re.identifier
where p_fichier_3 is not NULL AND ws_pully_db_topobase = 'PULLY_ASS';

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
re.identifier,
re.obj_id,
3775,
3801,
left(p_fichier_4,200)
from pully_ass.aw_haltung
left join qgep_od.vw_qgep_reach re ON fid::text = re.identifier
where p_fichier_4 is not NULL AND ws_pully_db_topobase = 'PULLY_ASS';
