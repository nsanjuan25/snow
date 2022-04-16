create or replace view V_ECC_HA_DIMPURCHASEITEMCATEGORIES(
	PURCHASEITEMCATEGORYCODE,
	DATASOURCEKEY,
	PURCHASEITEMCATEGORYDESCRIPTION,
	PURCHASEITEMCATEGORYSTANDARDCODE,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DimPurchaseItemcategories
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-17      Carlos Carrillo         Initial Revision
  */
	SELECT
		  purchaseitemcategory.PurchaseItemCategoryCode
		, (Select DataSourceKey From PUBLIC.DimDataSources Where DataSourceName = 'SAP') as DataSourceKey
		, purchaseitemcategory.Description as PurchaseItemCategoryDescription
		, IFNULL(purchaseitemcategorystd.PurchaseItemCategoryStdCode,'Undefined') as PurchaseItemCategoryStandardCode
		, purchaseitemcategory.SNFLK_UpdatedOn as SrclastModifiedDate
		, HASH(purchaseitemcategory.Description, purchaseitemcategorystd.PurchaseItemCategoryStdCode) AS HASH_VALUE
	from 
		CONFORMED.SCMDB_purchaseitemcategory as purchaseitemcategory 
		LEFT OUTER JOIN CONFORMED.SCMDB_purchaseitemcategorystd as purchaseitemcategorystd ON purchaseitemcategory.PurchaseItemCategoryStdId = purchaseitemcategorystd.PurchaseItemCategoryStdId
	WHERE 
		purchaseitemcategory.DataSourceId = 6;