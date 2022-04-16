create or replace view V_DIMSALESDOCUMENTTYPES(
	DATASOURCEKEY,
	SALESDOCUMENTTYPE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DIMSALESDOCUMENTTYPES table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-10      Noel San Juan          Initial Revision
*/
SELECT DISTINCT
	1								AS DataSourceKey,
    IFNULL(a.SalesDocumentType,'')  AS SalesDocumentType,
    HASH
    ( 
		IFNULL(a.SalesDocumentType,'')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SAP_SALESORDERS a;