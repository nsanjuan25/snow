create or replace view V_DIMSHIPPINGTYPES(
	DATASOURCEKEY,
	SHIPPINGTYPE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DIMSHIPPINGTYPES table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
	1						   AS DataSourceKey,
    IFNULL(a.ShippingType,'')  AS ShippingType,
    HASH
    ( 
		IFNULL(a.ShippingType,'')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SAP_SALESORDERS a;