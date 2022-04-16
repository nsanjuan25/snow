create or replace view V_DIMORDERTYPES(
	DATASOURCEKEY,
	ORDERTYPE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DIMORDERTYPES table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
	1						AS DataSourceKey,
    IFNULL(a.OrderType,'')  AS OrderType,
    HASH
    ( 
		IFNULL(a.OrderType,'')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SAP_ORDERS a;