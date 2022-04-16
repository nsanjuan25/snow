create or replace view V_DIMCAMPUS(
	DATASOURCEKEY,
	SITEGROUPID,
	SITEGROUPCODE,
	DESCRIPTION,
	UPDATEDON,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMCAMPUS
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-01-26      Carlos Carrillo             Initial Revision
  */
SELECT 
		 (SELECT DataSourceKey FROM PUBLIC.DimDataSources WHERE DataSourceName = 'SAP') AS DataSourceKey
		, a.SiteGroupID
		, LTRIM(RTRIM(a.SiteGroupCode)) AS SiteGroupCode
		, a.Description
		, a.SNFLK_UPDATEDON           AS UPDATEDON 
		, hash(a.SiteGroupID,a.SiteGroupCode,a.Description,a.SNFLK_UPDATEDON)  AS HASH_VALUE
				
	FROM 
		CONFORMED.SCMDB_SITEGROUP  a
	WHERE 
		a.Description LIKE '%Campus%';