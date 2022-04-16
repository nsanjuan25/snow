create or replace view V_REGIONTOCAMPUS(
	REGIONCODE,
	REGIONDESCRIPTION,
	CAMPUSCODE,
	CAMPUSDESCRIPTION,
	SEQ,
	DATASOURCEKEY
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DIMCAMPUS
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-01-27      Carlos Carrillo         Initial Revision
  */
SELECT 
		aa.RegionCode
      , aa.RegionDescription
      , aa.CampusCode
      , aa.CampusDescription
      , aa.Seq 
      , 1 AS DataSourceKey --> Hardcode since data comes from JDB
	FROM 
	(
		SELECT 
		  Region.RegionCode RegionCode
		, Region.RegionDescription
		, Campus.CampusCode CampusCode
		, Campus.CampusDescription
		, ROW_NUMBER() 
            OVER (
                  PARTITION BY Campus.Campuscode 
				  ORDER BY ifnull(Region.RegionCode, '1') DESC
                  ) Seq     
		FROM 
			(
				SELECT DISTINCT 
					  c.siteid CampusSiteId 
					, d.SiteGroupCode As CampusCode
					, d.Description CampusDescription
				FROM 
					CONFORMED.SCMDB_SITEGROUPTOSITE  c 
					FULL OUTER JOIN CONFORMED.SCMDB_SITEGROUP d on c.SiteGroupID = d.SiteGroupID  
				WHERE  
					d.Description LIKE '%Campus%'
			) Campus
			LEFT OUTER JOIN
				(
					SELECT DISTINCT 
						  c.siteid RegionSiteId
						, d.SiteGroupCode as RegionCode
						, d.Description RegionDescription
					FROM 
						CONFORMED.SCMDB_SITEGROUPTOSITE  c 
						FULL OUTER JOIN  CONFORMED.SCMDB_SITEGROUP d on c.SiteGroupID = d.SiteGroupID  
					WHERE  
						d.description LIKE '%Region%'
				) Region
					ON Region.RegionSiteId = Campus.CampusSiteId 
			)  aa 
WHERE 
    aa.seq=1 ;