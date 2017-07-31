-- connect reaches to wastewater nodes
UPDATE qgep.od_reach_point rp
SET fk_wastewater_networkelement = no.obj_id 
FROM qgep.od_wastewater_node no WHERE st_buffer(no.situation_geometry, 0.1) && rp.situation_geometry;

-- create node where missing 
INSERT INTO qgep.vw_wastewater_node ( situation_geometry ) 
SELECT DISTINCT rp1.situation_geometry FROM qgep.od_reach_point rp1
LEFT JOIN qgep.od_reach_point rp2
on rp1.situation_geometry = rp2.situation_geometry AND rp1.obj_id <> rp2.obj_id
WHERE rp1.fk_wastewater_networkelement IS NULL;

-- connect reaches points to newly created nodes
UPDATE qgep.od_reach_point rp
SET fk_wastewater_networkelement = no.obj_id 
FROM qgep.od_wastewater_node no WHERE no.situation_geometry = rp.situation_geometry;

REFRESH MATERIALIZED VIEW qgep.vw_network_segment ;
REFRESH MATERIALIZED VIEW qgep.vw_network_node ;


-- write manhole identifiers in reach points
update qgep.od_reach_point rp 
	set identifier = ws.identifier 
	from qgep.od_wastewater_networkelement ne, qgep.od_wastewater_structure ws 
	where rp.fk_wastewater_networkelement = ne.obj_id and ne.fk_wastewater_structure = ws.obj_id;
