BEGIN TRANSACTION;

CREATE OR REPLACE VIEW qgep.vw_manhole_sige AS

SELECT
  MH.obj_id
, MH.depth
, MH.dimension1
, MH.dimension2
, MH.function
, MH.material
, MH.surface_inflow
, MH.old_obj_id

, WS.accessibility
, WS.contract_section
, WS.detail_geometry_geometry
, WS.detail_geometry_3d_geometry
, WS.financing, gross_costs
, WS.identifier
, WS.inspection_interval
, WS.location_name
, WS.records
, WS.remark
, WS.renovation_necessity
, WS.replacement_value
, WS.rv_base_year
, WS.rv_construction_type
, WS.status
, WS.structure_condition
, WS.subsidies
, WS.year_of_construction
, WS.year_of_replacement
, WS.last_modification
, WS.dataowner
, WS.provider
, WS.fk_owner
, WS.fk_operator
  FROM qgep.od_manhole MH
LEFT JOIN qgep.od_wastewater_structure WS
  ON WS.obj_id = MH.obj_id;

-------------------------------------------------------
-- MANHOLE INSERT
-- Function: vw_manhole_insert()
-------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_manhole_insert_sige()
  RETURNS trigger AS
$BODY$
DECLARE
  ws_obj_id character varying(16);
BEGIN
  INSERT INTO qgep.od_wastewater_structure (
            obj_id
            , accessibility
            , contract_section
            , detail_geometry_geometry
            , detail_geometry_3d_geometry
            , financing
            , gross_costs
            , identifier
            , inspection_interval
            , location_name
            , records
            , remark
            , renovation_necessity
            , replacement_value
            , rv_base_year
            , rv_construction_type
            , status
            , structure_condition
            , subsidies
            , year_of_construction
            , year_of_replacement
            , last_modification
            , dataowner
            , provider
            , fk_owner
            , fk_operator )
    VALUES ( qgep.generate_oid('od_manhole') -- obj_id
            , NEW.accessibility
            , NEW.contract_section
            , NEW.detail_geometry_geometry
            , NEW.detail_geometry_3d_geometry
            , NEW.financing
            , NEW.gross_costs
            , NEW.identifier
            , NEW.inspection_interval
            , NEW.location_name
            , NEW.records
            , NEW.remark
            , NEW.renovation_necessity
            , NEW.replacement_value
            , NEW.rv_base_year
            , NEW.rv_construction_type
            , NEW.status
            , NEW.structure_condition
            , NEW.subsidies
            , NEW.year_of_construction
            , NEW.year_of_replacement
            , NEW.last_modification
            , NEW.dataowner
            , NEW.provider
            , NEW.fk_owner
            , NEW.fk_operator
           )
           RETURNING obj_id INTO NEW.obj_id;

  INSERT INTO qgep.od_manhole(
              obj_id
            , depth
            , dimension1
            , dimension2
            , function
            , material
            , surface_inflow
            , old_obj_id
            )
            VALUES(
              NEW.obj_id -- obj_id
            , NEW.depth -- depth
            , NEW.dimension1 -- dimension1
            , NEW.dimension2 -- dimension2
            , NEW.function -- function
            , NEW.material -- material
            , NEW.surface_inflow -- surface_inflow
            , NEW.old_obj_id
            );

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

DROP TRIGGER IF EXISTS vw_manhole_ON_INSERT ON qgep.vw_manhole_sige;

CREATE TRIGGER vw_manhole_ON_INSERT INSTEAD OF INSERT ON qgep.vw_manhole_sige
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_manhole_insert_sige();


END TRANSACTION;