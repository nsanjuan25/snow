create or replace view V_SCMDB_SAT_SITEPART(
	SITECODE,
	SITEPARTCODE,
	SITEPARTDESCRIPTION
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
    SITECODE, 
    SITEPARTCODE,
    SITEPARTDESCRIPTION
FROM 
    CONFORMED.SCMDB_SAT_SITEPART;