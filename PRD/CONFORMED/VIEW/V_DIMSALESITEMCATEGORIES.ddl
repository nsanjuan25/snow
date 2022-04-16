create or replace view V_DIMSALESITEMCATEGORIES(
	DATASOURCEKEY,
	SALESITEMCATEGORY,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DIMSALESITEMCATEGORIES table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
	1								AS DataSourceKey,
    IFNULL(a.SalesItemCategory,'')  AS SalesItemCategory,
    HASH
    ( 
		IFNULL(a.SalesItemCategory,'')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SAP_SALESORDERS a;