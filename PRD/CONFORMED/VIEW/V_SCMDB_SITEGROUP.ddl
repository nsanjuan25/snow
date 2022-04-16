create or replace view V_SCMDB_SITEGROUP(
	SITECODE,
	SITENAME
) as
/*--------------------------------------------------------------------

This view is used to spend_analytics 
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-26      Noel San Juan          Initial Revision
*/
SELECT DISTINCT 
    sitegroupcode SiteCode, 
    description SiteName 
FROM 
    CONFORMED.SCMDB_SITEGROUP
ORDER BY 
    sitegroupcode ASC;