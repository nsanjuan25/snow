create or replace view V_DIMSUPPLIERTYPES(
	SUPPLIERTYPE,
	DATASOURCEKEY,
	ISCONTRACT,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DimSupplierTypes
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Carlos Carrillo         Initial Revision
  */
    SELECT  
		  CorporationMaintenanceValueName SupplierType
		, (SELECT DataSourceKey FROM PUBLIC.DimDataSources WHERE DataSourceName = 'SAP') DataSourceKey
		, 0 IsContract
		, SNFLK_UpdatedOn SrcLastModifiedDate	
		, HASH(CorporationMaintenanceValueName) As HASH_VALUE
	FROM 
		CONFORMED.SCMDB_CorporationMaintenanceValue 
	WHERE 
		CorporationMaintenanceID = 1
		AND CorporationMaintenanceValueName NOT IN ('GCM Supplier','OEM')

	UNION 

	SELECT  
		  CorporationMaintenanceValueName SupplierType
		, (SELECT DataSourceKey FROM PUBLIC.DimDataSources WHERE DataSourceName = 'SAP') DataSourceKey
		, 1 IsContract
		, SNFLK_UpdatedOn SrcLastModifiedDate	
		, HASH(CorporationMaintenanceValueName) As HASH_VALUE
	FROM 
		CONFORMED.SCMDB_CorporationMaintenanceValue 
	WHERE 
		CorporationMaintenanceID = 8;