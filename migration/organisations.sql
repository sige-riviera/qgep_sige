--Ancient id
--ALTER TABLE qgep.od_organisation  ADD COLUMN old_obj_id integer;

INSERT INTO qgep_od.organisation (obj_id,identifier) VALUES
(0,	'inconnu'),
(1,	'Pully'),
(2,	'Belmont-sur-Lausanne'),
(3,	'Lausanne'),
(4,	'Intercommunal'),
(5,	'Privé'),
(6,	'CFF'),
(7,	'Canton'),
(8,	'Confédération');

--Use belmont for completion (1 public, 2 privé, 3 inconnu)
--SIGE SPECIFIC
--INSERT INTO qgep.od_organisation (identifier) VALUES ('AITV SA');
