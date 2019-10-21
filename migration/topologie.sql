UPDATE qgep_od.reach_point
SET fk_wastewater_networkelement = selection.obj_id
FROM
(
SELECT obj_id,identifier

FROM qgep_od.wastewater_networkelement

WHERE obj_id LIKE '%WN%' OR obj_id LIKE '%WE%') AS selection
WHERE reach_point.identifier IS NOT NULL AND reach_point.identifier = selection.identifier;
