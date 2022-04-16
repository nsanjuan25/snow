create or replace view V_DIMMRPTYPES(
	MRPTYPECODE,
	MRPTYPESTANDARDCODE,
	DATASOURCEKEY,
	DEMANDSUPPLYINDICATOR,
	MRPTYPESDESCRIPTION,
	DEMANDTYPECODE,
	DEMANDTYPESTANDARDCODE,
	SUPPLYTYPECODE,
	SUPPLYTYPESTANDARDCODE,
	SUPPLYSTATUSCODE,
	SUPPLYSTATUSSTANDARDCODE,
	SRCLASTMODIFIEDDATE,
	INVENTORYTYPEKEY,
	INVENTORYTYPECODE,
	PROCESSINGRULE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DIMMRPTYPES
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-05      Carlos Carrillo         Initial Revision
  */
	SELECT 
          IFNULL(RTRIM( LTRIM( MRPTypeCode  ) ),'Undefined')    AS MRPTypeCode
        , IFNULL(MRPTypeStdCode,'Undefined')                    AS MRPTypeStandardCode
        , (Select DataSourceKey From PUBLIC.DimDataSources Where DataSourceName = 'SAP') as DataSourceKey
        , IFNULL(DemandSupplyIndicator,'')                      AS DemandSupplyIndicator
        , IFNULL(mrptype.Description,'')                        AS MRPTypesDescription
        , IFNULL(DemandTypeCode,'Undefined')                    AS DemandTypeCode
        , IFNULL(DemandTypeStdCode,'Undefined')                 AS DemandTypeStandardCode
        , IFNULL(SupplyTypeCode,'Undefined')                    AS SupplyTypeCode
        , IFNULL(SupplyTypeStdCode,'Undefined')                 AS SupplyTypeStandardCode
        , IFNULL(SupplyStatusCode,'Undefined')                  AS SupplyStatusCode
        , IFNULL(SupplyStatusStdCode,'Undefined')               AS SupplyStatusStandardCode
        , mrptype.SNFLK_updatedon                               AS SrcLastModifiedDate
        , IFNULL( DIT.InventoryTypeKey , 0 )                    AS InventoryTypeKey
        , IFNULL( InventoryType.InventoryTypeCode,'Undefined')  AS InventoryTypeCode
        , IFNULL( demandtype.ProcessingRule, 'Undefined')       AS ProcessingRule
        , HASH(MRPTypeStdCode,DemandSupplyIndicator,mrptype.Description,DemandTypeCode,DemandTypeStdCode,SupplyTypeCode,SupplyTypeStdCode,SupplyStatusCode,SupplyStatusStdCode,InventoryType.InventoryTypeCode, InventoryTypeKey) as 	hash_value
    FROM  
        CONFORMED.SCMDB_mrptype mrptype
        LEFT OUTER JOIN CONFORMED.SCMDB_MRPTYPESTD mrptypestd
            ON mrptype.MrpTypeStdId = mrptypestd.MrpTypeStdId

        LEFT OUTER JOIN CONFORMED.SCMDB_SUPPLYTYPE supplytype
            ON mrptype.SupplyTypeID = supplytype.SupplyTypeID 
            AND mrptype.DataSourceID = supplytype.DataSourceID

        LEFT OUTER JOIN CONFORMED.SCMDB_SUPPLYTYPESTD supplytypestd 
            ON (supplytypestd.SupplyTypeStdID = supplytype.SupplyTypeStdID ) 
        
        LEFT OUTER JOIN CONFORMED.SCMDB_SUPPLYSTATUS supplystatus 
            ON  (mrptype.SupplyStatusID = supplystatus.SupplyStatusID ) 
            AND mrptype.DataSourceID = supplystatus.DataSourceID
        
        LEFT OUTER JOIN CONFORMED.SCMDB_SUPPLYSTATUSSTD supplystatusstd 
            ON (supplystatusstd.SupplyStatusStdID = supplystatus.SupplyStatusStdID ) 
        
        LEFT OUTER JOIN CONFORMED.SCMDB_DEMANDTYPE demandtype 
            ON (mrptype.DemandTypeId = demandtype.DemandTypeId ) 
            AND mrptype.DataSourceID = demandtype.DataSourceID

        LEFT OUTER JOIN CONFORMED.SCMDB_DEMANDTYPESTD demandtypestd 
            ON (demandtypestd.DemandTypeStdId = demandtype.DemandTypeStdId )

        LEFT OUTER JOIN CONFORMED.SCMDB_INVENTORYTYPE InventoryType
            ON (mrptype.InventoryTypeID = InventoryType.InventoryTypeID)
        
        LEFT OUTER JOIN SAP.DimInventoryTypes DIT
            ON DIT.InventoryTypeCode = InventoryType.InventoryTypeCode 
            AND mrptype.DataSourceID = 6

    WHERE 
        mrptype.DataSourceID = 6;