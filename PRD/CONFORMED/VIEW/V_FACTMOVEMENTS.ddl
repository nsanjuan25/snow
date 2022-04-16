create or replace view V_FACTMOVEMENTS(
	DATASOURCEKEY,
	MOVEMENTTYPEKEY,
	PLANTKEY,
	MATERIALKEY,
	INVENTORYLOCATIONKEY,
	INVENTORYTYPEKEY,
	SPECIALSTOCKSKEY,
	AMLKEY,
	MANUFACTURERKEY,
	REASONTYPEKEY,
	SUPPLIERKEY,
	MATERIALGROUPKEY,
	EXCHANGERATEKEY,
	MOVEMENTDOCUMENTTYPE,
	MOVEMENTYEAR,
	MOVEMENTDOCUMENTNUMBER,
	MOVEMENTDOCUMENTITEM,
	SITECODE,
	SITEPARTCODE,
	POSTEDDTS,
	REFERENCEDOCUMENTNUMBER,
	MOVEMENTTYPECODE,
	BILLOFLADING,
	MOVEMENTCOMMENTS,
	LOCATION,
	BATCHNUMBER,
	INVENTORYTYPECODE,
	QUANTITY,
	MATERIALCOST,
	COMPANYORGANIZATIONCODE,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	DSCREATEUSER,
	DEBITCREDITINDICATOR,
	OWNERCORPORATIONDSCODE,
	CURRENCYCODE,
	SPECIALSTOCKSCODE,
	UNITOFMEASUREDSCODE,
	AMLREFERENCENUMBER,
	TRANSACTIONDTS,
	REASONTYPECODE,
	MOVEMENTITEMCOMMENTS,
	MOVEMENTINDICATOR,
	CORPORATIONDSTYPECODE,
	CORPORATIONDSTYPESTDCODE,
	ASSETNUMBER,
	ORDERNUMBER,
	COSTCENTER,
	WBSELEMENTCODE,
	GLACCOUNT,
	ACCOUNTINGLINEITEM,
	WBSELEMENT,
	UPDATEDON
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.FactMovements
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-03      Carlos Carrillo         Initial Revision
2021-07-14		Jagan					Add JPS 
2021-09-22  	Jagan					Add PLA 
*/                        
SELECT 
    1 as DataSourceKey
  , MovementTypeKey
  , PlantKey
  , MaterialKey
  , InventoryLocationKey
  , InventoryTypeKey
  , SpecialStocksKey
  , AMLKey
  , ManufacturerKey
  , ReasonTypeKey
  , SupplierKey
  , MaterialGroupKey
  , ExchangeRateKey
  , movementdocumenttype
  , movementyear
  , movementdocumentnumber
  , movementdocumentitem
  , sitecode 
  , sitepartcode  
  , posteddts
  , referencedocumentnumber
  , movementtypecode
  , billoflading
  , movementcomments
  , location
  , batchnumber
  , inventorytypecode
  , quantity  
  , materialcost  
  , companyorganizationcode
  , salesdocumentnumber
  , salesdocumentitem
  , purchasedocumentnumber
  , purchasedocumentitem
  , dscreateuser
  , debitcreditindicator
  , ownercorporationdscode
  , currencycode
  , specialstockscode
  , unitofmeasuredscode
  , amlreferencenumber
  , transactiondts
  , reasontypecode
  , movementitemcomments
  , movementindicator
  , corporationdstypecode
  , corporationdstypestdcode
  , assetnumber
  , ordernumber
  , costcenter 
  , wbselementcode 
  , glaccount  
  , accountinglineitem     
  , WBSElement
  , UpdatedOn
FROM 
    conformed.v_ecc_ha_FactMovements

UNION ALL

SELECT 
    2 as DataSourceKey
  , MovementTypeKey
  , PlantKey
  , MaterialKey
  , InventoryLocationKey
  , InventoryTypeKey
  , SpecialStocksKey
  , AMLKey
  , ManufacturerKey
  , ReasonTypeKey
  , SupplierKey
  , MaterialGroupKey
  , ExchangeRateKey
  , movementdocumenttype
  , movementyear
  , movementdocumentnumber
  , movementdocumentitem
  , sitecode 
  , sitepartcode  
  , posteddts
  , referencedocumentnumber
  , movementtypecode
  , billoflading
  , movementcomments
  , location
  , batchnumber
  , inventorytypecode
  , quantity  
  , materialcost  
  , companyorganizationcode
  , salesdocumentnumber
  , salesdocumentitem
  , purchasedocumentnumber
  , purchasedocumentitem
  , dscreateuser
  , debitcreditindicator
  , ownercorporationdscode
  , currencycode
  , specialstockscode
  , unitofmeasuredscode
  , amlreferencenumber
  , transactiondts
  , reasontypecode
  , movementitemcomments
  , movementindicator
  , corporationdstypecode
  , corporationdstypestdcode
  , assetnumber
  , ordernumber
  , costcenter 
  , wbselementcode 
  , glaccount  
  , accountinglineitem     
  , WBSElement
  , UpdatedOn
FROM 
    conformed.v_Hcc_ha_FactMovements
UNION ALL
SELECT 
    5 as DataSourceKey
  , MovementTypeKey
  , PlantKey
  , MaterialKey
  , InventoryLocationKey
  , InventoryTypeKey
  , SpecialStocksKey
  , AMLKey
  , ManufacturerKey
  , ReasonTypeKey
  , SupplierKey
  , MaterialGroupKey
  , ExchangeRateKey
  , movementdocumenttype
  , movementyear
  , movementdocumentnumber
  , movementdocumentitem
  , sitecode 
  , sitepartcode  
  , posteddts
  , referencedocumentnumber
  , movementtypecode
  , billoflading
  , movementcomments
  , location
  , batchnumber
  , inventorytypecode
  , quantity  
  , materialcost  
  , companyorganizationcode
  , salesdocumentnumber
  , salesdocumentitem
  , purchasedocumentnumber
  , purchasedocumentitem
  , dscreateuser
  , debitcreditindicator
  , ownercorporationdscode
  , currencycode
  , specialstockscode
  , unitofmeasuredscode
  , amlreferencenumber
  , transactiondts
  , reasontypecode
  , movementitemcomments
  , movementindicator
  , corporationdstypecode
  , corporationdstypestdcode
  , assetnumber
  , ordernumber
  , costcenter 
  , wbselementcode 
  , glaccount  
  , accountinglineitem     
  , WBSElement
  , UpdatedOn
FROM 
    conformed.v_jps_ha_FactMovements
UNION ALL
SELECT 
    4 as DataSourceKey
  , MovementTypeKey
  , PlantKey
  , MaterialKey
  , InventoryLocationKey
  , InventoryTypeKey
  , SpecialStocksKey
  , AMLKey
  , ManufacturerKey
  , ReasonTypeKey
  , SupplierKey
  , MaterialGroupKey
  , ExchangeRateKey
  , movementdocumenttype
  , movementyear
  , movementdocumentnumber
  , movementdocumentitem
  , sitecode 
  , sitepartcode  
  , posteddts
  , referencedocumentnumber
  , movementtypecode
  , billoflading
  , movementcomments
  , location
  , batchnumber
  , inventorytypecode
  , quantity  
  , materialcost  
  , companyorganizationcode
  , salesdocumentnumber
  , salesdocumentitem
  , purchasedocumentnumber
  , purchasedocumentitem
  , dscreateuser
  , debitcreditindicator
  , ownercorporationdscode
  , currencycode
  , specialstockscode
  , unitofmeasuredscode
  , amlreferencenumber
  , transactiondts
  , reasontypecode
  , movementitemcomments
  , movementindicator
  , corporationdstypecode
  , corporationdstypestdcode
  , assetnumber
  , ordernumber
  , costcenter 
  , wbselementcode 
  , glaccount  
  , accountinglineitem     
  , WBSElement
  , UpdatedOn
FROM 
    conformed.v_pla_ha_FactMovements;