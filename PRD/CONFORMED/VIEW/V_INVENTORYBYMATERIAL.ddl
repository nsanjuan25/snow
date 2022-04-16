create or replace view V_INVENTORYBYMATERIAL(
	MATERIALKEY,
	SNAPSHOTDATEKEY,
	ONHANDQUANTITY,
	ONHANDNONNETTABLEQUANTITY,
	CONSIGNEDQUANTITY,
	CONSIGNEDNONNETTABLEQUANTITY
) as ( 
/*
Created date	: 2021-05-24
Created By		: Jayashri Salampuriya
Start Revision History            
-----------------------------------------------------------------------------------------------------------
Date			Developer           Revision Description
----------		--------------		-----------------------------------------------------------------------
20180507        Juan Cedeno         Initial Revision to get Total Inventory by Material for FactMaterials
-----------------------------------------------------------------------------------------------------------
*/
    SELECT 
	      INV.MaterialKey
        , INV.SnapshotDateKey
	    , IFNULL( SUM( CASE WHEN INV.NettableFlag = 0	THEN INV.Quantity END )                               , 0 ) AS OnHandQuantity
	    , IFNULL( SUM( CASE WHEN INV.NettableFlag = 1	THEN INV.Quantity END ) 	                          , 0 ) AS OnHandNonNettableQuantity
	    , IFNULL( SUM( CASE WHEN INV.NettableFlag = 0 AND SS.SpecialStocksCode = 'K' THEN INV.Quantity END	) , 0 ) AS ConsignedQuantity
	    , IFNULL( SUM( CASE WHEN INV.NettableFlag = 1 AND SS.SpecialStocksCode = 'K' THEN INV.Quantity END	) , 0 ) AS ConsignedNonNettableQuantity
    FROM
	    sap.FactInventory INV
	    INNER JOIN sap.DimSpecialStocks	AS SS	ON INV.SpecialStocksKey = SS.SpecialStocksKey
    GROUP BY
	      INV.MaterialKey
        , INV.SnapshotDateKey
);