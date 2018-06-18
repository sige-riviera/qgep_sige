--Ancient id
--ALTER TABLE qgep.od_organisation  ADD COLUMN old_obj_id integer;

INSERT INTO qgep_od.organisation (obj_id,identifier)
SELECT id, value FROM belmont_ass.ba_eigentumsverhaeltnis_tbd;

--Use belmont for completion (1 public, 2 privé, 3 inconnu)
--SIGE SPECIFIC
--INSERT INTO qgep.od_organisation (identifier) VALUES ('AITV SA');
