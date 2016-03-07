
-- write manhole identifiers in reach points
update qgep.od_reach_point rp 
	set identifier = ws.identifier 
	from qgep.od_wastewater_networkelement ne, qgep.od_wastewater_structure ws 
	where rp.fk_wastewater_networkelement = ne.obj_id and ne.fk_wastewater_structure = ws.obj_id;
