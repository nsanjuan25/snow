create or replace view V_DIMPURCHASESCHEDULETYPES(
	PURCHASESCHEDULETYPECODE,
	DESCRIPTION,
	PURCHASESCHEDULETYPESTANDARDCODE,
	DATASOURCEKEY,
	MRPDOCUMENTTYPECODE,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DimPurchaseScheduleTypes
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-17      Carlos Carrillo         Initial Revision
  */
	SELECT 
		  LTRIM(RTRIM( pst.PurchaseScheduleTypeCode )) AS PurchaseScheduleTypeCode
		, pst.Description AS Description
		, IFNULL(psts.PurchaseScheduleTypeStdCode, 'Undefined') AS PurchaseScheduleTypeStandardCode
		, (SELECT DataSourceKey FROM PUBLIC.DimDataSources where DataSourceName = 'SAP') As DataSourceKey
		, pst.MRPDocumentTypeCode AS MRPDocumentTypeCode
		, pst.SNFLK_UpdatedOn AS SrclastModifiedDate
		, HASH(pst.Description,psts.PurchaseScheduleTypeStdCode,pst.MRPDocumentTypeCode) AS HASH_VALUE
	FROM 
		CONFORMED.SCMDB_PurchaseScheduleType pst
		LEFT OUTER JOIN CONFORMED.SCMDB_PurchaseScheduleTypestd psts ON pst.PurchaseScheduleTypeStdId = psts.PurchaseScheduleTypeStdId
	WHERE 
		pst.DataSourceID = 6;