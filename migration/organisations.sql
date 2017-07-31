--Ancient id
--ALTER TABLE qgep.od_organisation  ADD COLUMN old_obj_id integer;

INSERT INTO qgep.od_organisation (obj_id,identifier)
SELECT id, value FROM sa.ba_eigentumsverhaeltnis_tbd;

--SIGE SPECIFIC
--INSERT INTO qgep.od_organisation (identifier) VALUES ('AITV SA');
