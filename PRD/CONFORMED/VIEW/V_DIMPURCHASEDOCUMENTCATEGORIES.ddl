create or replace view V_DIMPURCHASEDOCUMENTCATEGORIES(
	DATASOURCEKEY,
	PURCHASEDOCUMENTCATEGORYTYPECODE,
	PURCHASEDOCUMENTCATEGORYTYPESTANDARDCODE,
	DESCRIPTION,
	DELETEFLAG,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DimPurchaseDocumentCategories
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-27      SRIDHAR                 Initial Revision
  */
    SELECT 
		 (Select DataSourceKey From PUBLIC.DimDataSources Where DataSourceName = 'SAP') as DataSourceKey
		, LTRIM(RTRIM( pdt.PURCHASEDOCUMENTCATEGORYCODE )) AS PurchaseDocumentCategoryTypeCode
		, pdts.PURCHASEDOCUMENTCATEGORYSTDCode AS  PurchaseDocumentCategoryTypeStandardCode
		, IFNULL(pdt.Description,'Undefined') AS Description
		, 0 AS DeleteFlag
		, pdt.SNFLK_UpdatedOn as SrclastModifiedDate
		, HASH(pdt.Description,pdts.PURCHASEDOCUMENTCATEGORYSTDID,pdt.Description,0) AS HASH_VALUE
	FROM 
		(
			SELECT 
				EJPDT.DataSourceID
              , EJPDT.PURCHASEDOCUMENTCATEGORYCODE
              , EJPDT.PURCHASEDOCUMENTCATEGORYSTDID
              , EJPDT.Description
              , EJPDT.CreateUser
              , EJPDT.CreateDTS
              , EJPDT.UpdateUser
              , EJPDT.UpdateDTS
              , EJPDT.SNFLK_UpdatedOn 
			FROM 
				 CONFORMED.SCMDB_PURCHASEDOCUMENTCATEGORY  AS EJPDT
			WHERE 
				EJPDT.DataSourceID = 6
		) pdt
	LEFT OUTER JOIN CONFORMED.SCMDB_PURCHASEDOCUMENTCATEGORYSTD pdts
		ON pdt.PURCHASEDOCUMENTCATEGORYSTDID = pdts.PURCHASEDOCUMENTCATEGORYSTDID;