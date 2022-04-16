create or replace view V_DIMPURCHASEDOCUMENTTYPES(
	DATASOURCEKEY,
	PURCHASEDOCUMENTTYPECODE,
	PURCHASEDOCUMENTTYPESTANDARDCODE,
	DESCRIPTION,
	DELETEFLAG,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DimPurchaseDocumentTypes
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-17      Carlos Carrillo         Initial Revision
  */
    SELECT 
		 (Select DataSourceKey From PUBLIC.DimDataSources Where DataSourceName = 'SAP') as DataSourceKey
		, LTRIM(RTRIM( pdt.PurchaseDocumentTypeCode )) AS PurchaseDocumentTypeCode
		, IFNULL(pdts.PurchaseDocumentTypeStdCode,'Undefined') AS  PurchaseDocumentTypeStandardCode
		, IFNULL(pdt.Description,'Undefined') AS Description
		, pdt.DeleteFlag AS DeleteFlag
		, pdt.SNFLK_UpdatedOn as SrclastModifiedDate
		, HASH(pdt.Description,pdts.PurchaseDocumentTypeStdCode,pdt.Description,pdt.DeleteFlag) AS HASH_VALUE
	FROM 
		(
			SELECT 
				EJPDT.DataSourceID
              , ifnull(EJPDT.PurchaseDocumentTypeCode,'') PurchaseDocumentTypeCode
              , EJPDT.PurchaseDocumentTypeStdID
              , EJPDT.Description
              , EJPDT.ImportJobID
              , EJPDT.DeleteFlag
              , EJPDT.CreateUser
              , EJPDT.CreateDTS
              , EJPDT.UpdateUser
              , EJPDT.UpdateDTS
              , EJPDT.SNFLK_UpdatedOn 
			FROM 
				CONFORMED.SCMDB_PurchaseDocumentType AS EJPDT
			WHERE 
				EJPDT.DataSourceID = 6
		) pdt
	LEFT OUTER JOIN CONFORMED.SCMDB_PurchaseDocumentTypestd pdts
		ON pdt.PurchaseDocumentTypeStdID = pdts.PurchaseDocumentTypeStdID;