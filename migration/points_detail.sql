/***************************************************************************
    TopoBase2 to QGEP migration script for
    * Points de construction
     --------------------------------------
    Date                 : 1.6.2015
    Copyright            : (C) 2015 Matthias Kuhn
    Email                : matthias at opengis dot ch
     -------------------------------------
    Pimped by Arnaud Poncet-Montanges 2017
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/**
 * This script temporarily sets the identifier of the wastewater structure (manhole)
 * to the old fid. This is done in order to allow adding access aids based on the fid
 * subsequently.
 * At the end of the script the old fid is replaced with the real identifier.
 */

/* Clean the table before import*/

TRUNCATE qgep_dr.constructionpoint;
TRUNCATE qgep_dr.constructionline;

ALTER SEQUENCE qgep_dr.constructionpoint_id_seq RESTART 1;
ALTER SEQUENCE qgep_dr.constructionline_id_seq RESTART 1;

/*Insertion des points de détail Pully*/

INSERT INTO qgep_dr.constructionpoint
(
altitude,
code,
remark,
geometry
)

SELECT
coalesce(geo.z1,0),
400,
concat('PdD Pully ', punkt.fid),
ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781)
FROM
pully_ass.aw_detail_punkt punkt
LEFT JOIN pully_ass.aw_detail_punkt_geo geo ON punkt.gid = geo.gid
--LEFT JOIN pully_ass.aw_detail_punkt_art_tbd art ON punkt.id_art = art.id
--LEFT JOIN pully_ass.aw_detail_punkt_fkt_tbd fkt ON punkt.id_funktion = fkt.id
--LEFT JOIN pully_ass.aw_lagegenauigkeit_tbd lage ON punkt.id_lagegenauigkeit = lage.id
WHERE ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND id_art = 1;

/*Insertion des points de détail Belmont*/

INSERT INTO qgep_dr.constructionpoint
(
altitude,
code,
remark,
geometry
)

SELECT
coalesce(geo.z1,0),
400,
concat('PdD Belmont ', punkt.fid),
ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781)
FROM
belmont_ass.aw_detail_punkt punkt
LEFT JOIN belmont_ass.aw_detail_punkt_geo geo ON punkt.gid = geo.gid
WHERE ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND id_art = 1;

/* Insertion des points de conduite Pully */

INSERT INTO qgep_dr.constructionpoint
(
altitude,
code,
remark,
geometry
)

SELECT
coalesce(geo.z1,0),
401,
concat('PdC Pully ', punkt.fid),
ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781)
FROM
pully_ass.aw_detail_punkt punkt
LEFT JOIN pully_ass.aw_detail_punkt_geo geo ON punkt.gid = geo.gid
WHERE ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND id_art = 3;

/* Insertion des points de conduite Belmont */

INSERT INTO qgep_dr.constructionpoint
(
altitude,
code,
remark,
geometry
)

SELECT
coalesce(geo.z1,0),
401,
concat('PdC Belmont ', punkt.fid),
ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781)
FROM
belmont_ass.aw_detail_punkt punkt
LEFT JOIN belmont_ass.aw_detail_punkt_geo geo ON punkt.gid = geo.gid
WHERE ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND id_art = 3;

/* Insertion des points de raccordement Pully */

INSERT INTO qgep_dr.constructionpoint
(
altitude,
code,
remark,
geometry
)

SELECT
coalesce(geo.z1,0),
403,
concat('PdR Pully ', punkt.fid),
ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781)
FROM
pully_ass.aw_anschlusspunkte punkt
LEFT JOIN pully_ass.aw_anschlusspunkte_geo geo ON punkt.gid = geo.gid
WHERE ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND id_art = 3;

/* Insertion des points de raccordement Belmont */

INSERT INTO qgep_dr.constructionpoint
(
altitude,
code,
remark,
geometry
)

SELECT
coalesce(geo.z1,0),
403,
concat('PdR Belmont ', punkt.fid),
ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781)
FROM
belmont_ass.aw_anschlusspunkte punkt
LEFT JOIN belmont_ass.aw_anschlusspunkte_geo geo ON punkt.gid = geo.gid
WHERE ST_SetSRID(ST_MakePoint( coalesce(geo.y1,0), coalesce(geo.x1,0), coalesce(geo.z1,0)),21781)::geometry(PointZ, 21781) IS NOT NULL
AND id_art = 3;
