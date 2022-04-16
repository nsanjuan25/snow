create or replace view V_SCMDB_SUPPLIER(
	SUPPLIERCODE,
	SUPPLIERNAME
) as
/*--------------------------------------------------------------------

This view is used to spend_analytics 
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-01      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
    CAST(CORPORATIONID AS STRING) AS SUPPLIERCODE, 
    CORPORATIONNAME AS  SUPPLIERNAME 
FROM 
    CONFORMED.SCMDB_CORPORATION;