create or replace view V_DIMSALESDOCUMENTCATEGORIES(
	DATASOURCEKEY,
	SALESDOCUMENTCATEGORY,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DIMSALESDOCUMENTCATEGORIES table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
	1									        AS DataSourceKey,
    IFNULL(UPPER(a.SalesDocumentCategory),'')   AS SalesDocumentCategory,
    HASH
    ( 
		UPPER(a.SalesDocumentCategory)
    ) AS HASH_VALUE
FROM 
    CONFORMED.SAP_SALESORDERS a;