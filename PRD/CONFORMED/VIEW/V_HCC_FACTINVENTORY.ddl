create or replace view V_HCC_FACTINVENTORY(
	DATASOURCEKEY,
	PLANTKEY,
	MATERIALKEY,
	INVENTORYTYPEKEY,
	SUPPLIERKEY,
	LOCATIONKEY,
	STOCKDATEKEY,
	BATCHNUMBER,
	SERIALNUMBER,
	SPECIALSTOCKSKEY,
	NETTABLEFLAG,
	QUANTITY,
	UNITOFMEASURECODE,
	SNAPSHOTDATEKEY,
	MRPINDICATOR,
	STOCKTYPEKEY
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into v_HCC_FactInventory
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-04-14     SRIDHAR                 Initial Revision     
*/
SELECT 
          DatasourceKey
	    , PlantKey
	    , MaterialKey
	    , InventoryTypeKey
	    , SupplierKey
	    , LocationKey
	    , StockDateKey
	    , BatchNumber
	    , SerialNumber
	    , SpecialStocksKey
	    , NettableFlag
	    , Quantity
	    , UnitOfMeasureCode
	    , SnapshotDateKey
	    , MRPIndicator
        , StockTypeKey
    FROM
	    (
		    SELECT
                  I.DatasourceKey
			    , IFNULL(p.PlantKey,0) AS PlantKey
			    , IFNULL(M.MaterialKey,0) AS MaterialKey
			    , IFNULL(tc.InventoryTypeKey, 0)										 InventoryTypeKey 
			    , IFNULL(Su.SupplierKey, 0)												 SupplierKey 
			    , IFNULL(loc.InventoryLocationKey, 0)									 LocationKey 
			    , I.Stockdate															 StockDateKey 
			    , I.BatchNumber
			    , I.SerialNumber
			    , IFNULL(ss.SpecialStocksKey, 0)										 SpecialStocksKey 
			    , I.NettableFlag
			    , I.Quantity
			    , UnitOfMeasureCode
			    , InventoryDTS  	 SnapshotDateKey 
			    , I.MRPIndicator
                , coalesce( DST.StockTypeKey ,0) AS  StockTypeKey 
		    FROM
			    CONFORMED.V_HCC_HA_ONHAND						I
			    LEFT OUTER JOIN SAP.DimPlants					p	ON I.Sitecode = p.plantcode
															    AND p.DataSourceKey		= I.datasourcekey
			    LEFT OUTER JOIN SAP.Dimmaterials					m	ON I.SitePartCode		= m.materialCode
															    AND p.plantkey			= m.plantkey
															    AND m.DataSourceKey		= I.datasourcekey
			    LEFT OUTER JOIN SAP.DimInventoryTypes		tc	ON I.InventoryTypeCode	= tc.InventoryTypeCode
															    AND tc.DataSourceKey	= I.datasourcekey
			    LEFT OUTER JOIN 
                    (
                       SELECT 
                        * 
                        , ROW_NUMBER() OVER (PARTITION BY S.SupplierCode, S.DataSourceKey
                                           ORDER BY IFNULL(S.DeleteFlag,0) ASC ) RN
                      FROM 
                        SAP.DimSuppliers S
                    )Su	ON I.suppliercode		= Su.suppliercode
                        AND Su.DataSourceKey	= I.datasourcekey
                        AND RN = 1
			    LEFT OUTER JOIN SAP.DimInventoryLocations	loc ON I.Location			= loc.InventoryLocationCode
															    AND I.Sitecode= loc.PlantCode
															    AND loc.DataSourceKey	= I.datasourcekey
			    LEFT OUTER JOIN SAP.DimSpecialStocks		ss ON I.SpecialStocksCode	= ss.SpecialStocksCode
															    AND ss.DataSourceKey	= I.datasourcekey
                LEFT OUTER JOIN SAP.DimStockTypes AS DST    ON I.InventoryTypeCode         = DST.StockTypeCode
															    AND DST.DataSourceKey	= I.datasourcekey
	    ) AS A ;