-- Insertion des fichiers des chambres Pully

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
ws.identifier,
ws.obj_id,
3772,
3801,
image
from pully_ass.aw_schacht
left join qgep_od.vw_qgep_wastewater_structure ws ON fid::text = ws.identifier
where image is not NULL;

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
ws.identifier,
ws.obj_id,
3772,
3801,
image_1
from pully_ass.aw_schacht
left join qgep_od.vw_qgep_wastewater_structure ws ON fid::text = ws.identifier
where image_1 is not NULL;

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
ws.identifier,
ws.obj_id,
3772,
3801,
image_2
from pully_ass.aw_schacht
left join qgep_od.vw_qgep_wastewater_structure ws ON fid::text = ws.identifier
where image_2 is not NULL;

INSERT into qgep_od.vw_file
(
identifier,
object,
file_kind,
class,
_url
)

select
ws.identifier,
ws.obj_id,
3772,
3801,
image_3
from pully_ass.aw_schacht
left join qgep_od.vw_qgep_wastewater_structure ws ON fid::text = ws.identifier
where image_3 is not NULL;
