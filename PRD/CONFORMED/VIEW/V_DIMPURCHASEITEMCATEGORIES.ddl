create or replace view V_DIMPURCHASEITEMCATEGORIES(
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
		  ifnull( PurchaseItemCategoryCode, '') PurchaseItemCategoryCode
		, DataSourceKey
		, PurchaseItemCategoryDescription
		, PurchaseItemCategoryStandardCode
		, SrclastModifiedDate
		, HASH_VALUE
	from 
		CONFORMED.V_ecc_ha_DIMPURCHASEITEMCATEGORIES;