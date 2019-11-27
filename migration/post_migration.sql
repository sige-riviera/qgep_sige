-- Update identifiers for wastewater structures
UPDATE qgep_od.wastewater_structure AS ws
SET identifier = schacht.name
FROM migration.schacht AS schacht
WHERE ws.identifier = schacht.fid::text;

-- Update identifiers for reaches Pully
UPDATE qgep_od.vw_qgep_reach AS reach
SET identifier = haltung.name
FROM pully_ass.aw_haltung AS haltung
WHERE reach.ws_pully_db_topobase = 'PULLY_ASS'
AND reach.identifier = haltung.fid::text;

-- Update identifiers for reaches Belmont
UPDATE qgep_od.vw_qgep_reach AS reach
SET identifier = haltung.name
FROM belmont_ass.aw_haltung AS haltung
WHERE reach.ws_pully_db_topobase = 'BELMONT_ASS'
AND reach.identifier = haltung.fid::text;

-- Update identifiers for raccs Pully
UPDATE qgep_od.vw_qgep_reach AS reach
SET identifier = anschluss.name
FROM pully_ass.aw_anschlussleitung AS anschluss
WHERE reach.ws_pully_db_topobase = 'PULLY_ASS'
AND reach.identifier = anschluss.fid::text;

-- Update identifiers for raccs Belmont
UPDATE qgep_od.vw_qgep_reach AS reach
SET identifier = anschluss.name
FROM belmont_ass.aw_anschlussleitung AS anschluss
WHERE reach.ws_pully_db_topobase = 'BELMONT_ASS'
AND reach.identifier = anschluss.fid::text;

