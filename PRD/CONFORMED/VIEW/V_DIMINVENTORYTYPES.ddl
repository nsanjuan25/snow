create or replace view V_DIMINVENTORYTYPES(
	INVENTORYTYPECODE,
	DATASOURCEKEY,
	DESCRIPTION,
	PROCESSINGRULES,
	DELETEFLAG,
	INVENTORYTYPESTANDARDCODE,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DIMINVENTORYTYPES
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-05      Carlos Carrillo         Initial Revision
  */
SELECT 	DISTINCT
		  IFNULL(InventoryType.InventoryTypeCode, ' ') InventoryTypeCode
		, (Select DataSourceKey From PUBLIC.DimDataSources Where DataSourceName = 'SAP') as DataSourceKey
		,  IFNULL(InventoryType.Description, ' ') Description
		,  IFNULL(InventoryType.ProcessingRule , ' ')  ProcessingRules
		,  InventoryType.DeleteFlag
		,  IFNULL(InventoryTypeStd.InventoryTypeStdCode, ' ') InventoryTypeStandardCode
		,  InventoryType.SNFLK_UpdatedOn as SrclastModifiedDate
		,  HASH(InventoryType.Description,InventoryType.ProcessingRule,InventoryTypeStd.InventoryTypeStdCode ) AS hash_value
	FROM 
		 CONFORMED.SCMDB_inventorytype InventoryType
		LEFT OUTER JOIN CONFORMED.SCMDB_inventorytypestd InventoryTypeStd ON InventoryType.InventoryTypeStdID = InventoryTypeStd.InventoryTypeStdID
	WHERE 
		InventoryType.DataSourceID = 6;