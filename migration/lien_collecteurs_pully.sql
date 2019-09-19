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
3772,
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
3772,
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
3772,
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
3772,
3801,
left(p_fichier_4,200)
from pully_ass.aw_haltung
left join qgep_od.vw_qgep_reach re ON fid::text = re.identifier
where p_fichier_4 is not NULL AND ws_pully_db_topobase = 'PULLY_ASS';
