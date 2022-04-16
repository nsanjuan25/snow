create or replace view V_SCMDB_REGIONCAMPUSTOSITE(
	SITECODE,
	REGIONCODE,
	REGIONNAME,
	CAMPUSCODE,
	CAMPUSNAME,
	DATASOURCEKEY
) as
/*--------------------------------------------------------------------

This view is used in conformed.v_DimPlants view
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-17      Noel San Juan          Initial Revision
*/
SELECT
    IFNULL(Jabil_Site.SiteCode,'UNDEFINED')     AS SiteCode,
	IFNULL(RegionCampus.Regioncode,'UNDEFINED') AS RegionCode,
    IFNULL(RegionCampus.Regionname,'UNDEFINED') AS RegionName,
	IFNULL(RegionCampus.CampusCode,'UNDEFINED') AS CampusCode,
    IFNULL(RegionCampus.CampusName,'UNDEFINED') AS CampusName,
    1 AS DataSourceKey --> Hardcoded since  this is JDB ECC only
FROM
    CONFORMED.SCMDB_SITE Jabil_Site
    LEFT OUTER JOIN 
    (
			 SELECT 
				c.siteid,
				d.SiteGroupCode       AS Regioncode,
				d.description         AS Regionname,
				campus.SiteGroupCode  AS CampusCode,
				campus.description    AS CampusName                
			FROM 
				CONFORMED.SCMDB_SITEGROUPTOSITE c 
				FULL OUTER JOIN CONFORMED.SCMDB_SITEGROUP d ON c.SiteGroupID = d.SiteGroupID 
			FULL OUTER JOIN
				(
					SELECT 
						a.siteid,
						b.SiteGroupCode,
						b.description
					FROM 
						CONFORMED.SCMDB_SITEGROUPTOSITE a
						FULL OUTER JOIN CONFORMED.SCMDB_SITEGROUP b on a.SiteGroupID = b.SiteGroupID
					WHERE 
						LOWER(b.description) like 'campus%'
				) Campus ON c.siteid = campus.siteid 
			WHERE 
				LOWER(d.description) LIKE '%region%'
	) RegionCampus ON RegionCampus.Siteid = Jabil_Site.Siteid;