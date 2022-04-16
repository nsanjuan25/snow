create or replace view V_DIMCUSTOMERORDERTYPES(
	DATASOURCEKEY,
	CUSTOMERORDERTYPE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DimCustomerOrderTypes table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
	1                                 AS DataSourceKey,
    IFNULL(a.CustomerOrderType,'') AS CustomerOrderType,
    HASH
    ( 
		IFNULL(a.CustomerOrderType,'')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SAP_SALESORDERS a;