create or replace view V_SCMDB_MARKETSEGMENT(
	MARKETSEGMENTID,
	MARKETSEGMENT
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
    marketsegmentid, 
    upper(marketsegment) marketsegment 
FROM 
    CONFORMED.SCMDB_MARKETSEGMENT;