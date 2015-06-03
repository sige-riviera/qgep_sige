ALTER TABLE qgep.od_organisation  ADD COLUMN old_obj_id integer;

INSERT INTO qgep.od_organisation (old_obj_id,identifier)
SELECT id, value FROM sa.ba_eigentumsverhaeltnis_tbd;
