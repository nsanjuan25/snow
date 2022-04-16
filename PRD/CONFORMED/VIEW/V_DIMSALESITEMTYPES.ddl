create or replace view V_DIMSALESITEMTYPES(
	DATASOURCEKEY,
	SALESITEMTYPE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DIMSALESITEMTYPES table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
	1							AS DataSourceKey,
    IFNULL(a.SalesItemType,'')  AS SalesItemType,
    HASH
    ( 
		IFNULL(a.SalesItemType,'')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SAP_SALESORDERS a;