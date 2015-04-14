
-- assign access aid
UPDATE qgep.od_structure_part 
SET fk_wastewater_structure = mh.obj_id, identifier = NULL
FROM qgep.od_manhole mh WHERE mh.old_obj_id::varchar = identifier;



-- assign node to the reach
UPDATE qgep.od_reach_point rp
SET fk_wastewater_networkelement = no.obj_id 
FROM qgep.od_wastewater_node no WHERE no.situation_geometry = rp.situation_geometry;

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
