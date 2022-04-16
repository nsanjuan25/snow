create or replace view V_HCC_HA_FACTMOVEMENTS(
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

This view is used to insert data into SAP.v_FactMovements
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Juan Cedeno             Initial Revision
                                        view is using the latest 5 days for Delta purposes
*/                        
SELECT 
    
    ifnull(MT.MovementTypeKey,0)       as MovementTypeKey
  , ifnull(P.PlantKey,0)               as PlantKey
  , ifnull(PP.MaterialKey,0)           as MaterialKey
  , ifnull(L.InventoryLocationKey, 0 ) as InventoryLocationKey
  , ifnull(I.InventoryTypeKey, 0 )  as InventoryTypeKey
  , ifnull(SS.SpecialStocksKey, 0 ) as SpecialStocksKey
  , ifnull(A.AMLKey, 0 )          as AMLKey
  , ifnull(A.ManufacturerKey, 0 )          as ManufacturerKey
  , IFNULL(R.ReasonTypeKey, 0 )   as ReasonTypeKey
  , ifnull( S.SupplierKey , 0 )   as SupplierKey
  , ifnull(pp.Materialgroupkey, 0 ) as MaterialGroupKey
  , ifnull( ER.ExchangeRateKey , 0 ) as ExchangeRateKey
  , ifnull(mkpf.blart,'')         as movementdocumenttype
  , ifnull(mkpf.mjahr,'')         as movementyear
  , ifnull(mkpf.mblnr,'')         as movementdocumentnumber
  , ifnull(mseg.zeile,'')         as movementdocumentitem
  , ifnull(mseg.werks,'')         as sitecode 
  , ifnull(mseg.matnr,'')         as sitepartcode  
  , ifnull(to_date( case when mkpf.budat = '00000000' then '19000101' else mkpf.budat end , 'YYYYMMDD'),'1900-01-01') as posteddts
  , ifnull(mkpf.xblnr,'')         as referencedocumentnumber
  , ifnull(mseg.bwart,'UNDF')     as movementtypecode
  , ifnull(mkpf.frbnr,'')         as billoflading
  , ifnull(mkpf.bktxt,'')         as movementcomments
  , ifnull(mseg.lgort,'')         as location
  , ifnull(mseg.charg,'')         as batchnumber
  , ifnull(mseg.insmk,'')         as inventorytypecode
  , ifnull(mseg.menge,0)          as quantity  
  , ifnull(mseg.dmbtr,0) * IFNULL(DCDP.ExponentFactor,1)          as materialcost  
  , ifnull(mseg.bukrs,'')         as companyorganizationcode
  , ifnull(mseg.kdauf,'')         as salesdocumentnumber
  , ifnull(mseg.kdpos,'')         as salesdocumentitem
  , ifnull(mseg.ebeln,'')         as purchasedocumentnumber
  , ifnull(mseg.ebelp,'')         as purchasedocumentitem
  , ifnull(mkpf.usnam,'')         as dscreateuser
  , iff(mseg.shkzg = 'H','+','-') as    debitcreditindicator
  , ifnull(mseg.lifnr,'')         as ownercorporationdscode
  , ifnull(mseg.waers,'')         as currencycode
  , ifnull(mseg.sobkz,'')         as specialstockscode
  , ifnull(mseg.meins,'')         as unitofmeasuredscode
  , ifnull(mseg.ematn,'')         as amlreferencenumber
  , ifnull(to_date(case when mkpf.cpudt = '00000000' then '19000000' else mkpf.cpudt end , 'YYYYMMDD'),'1900-01-01') as transactiondts
  , ifnull(mseg.grund,'')         as reasontypecode
  , ifnull(mseg.sgtxt,'')         as movementitemcomments
  , ifnull(mseg.kzbew,'')         as movementindicator
  , ifnull(lfa1.ktokk,'')         as corporationdstypecode
  , case 
      when NOT(lfa1.lifnr is null or lfa1.lifnr = '') 
        then case 
          when  upper(lfa1.ktokk) like '%INT%' then 'Jabil' 
          when  upper(lfa1.ktokk) like '%MF%' then 'Manufacturer'
          else 'Supplier'
        end 
        else ''
      end as corporationdstypestdcode
  , ''                            as    assetnumber
  , ''                            as    ordernumber
  , ''                            as    costcenter 
  , ''                            as    wbselementcode 
  , ''                            as    glaccount  
  , ''                            as    accountinglineitem   
  
  , '' as WBSElement
  , mseg.FRMW_Extracted_on as UpdatedOn
  
FROM
    conformed.HCC_HA_MKPF  mkpf
    INNER JOIN conformed.HCC_HA_MSEG mseg    
    on mkpf.mblnr = mseg.mblnr 
    and mkpf.mjahr = mseg.mjahr
    LEFT OUTER JOIN conformed.HCC_HA_LFA1 lfa1
        on mseg.lifnr = lfa1.lifnr    
        
    LEFT OUTER JOIN sap.DimMovementTypes MT
        on ifnull(mseg.bwart,'UNDF') = LTRIM(RTRIM( MT.MovementTypeCode))
            AND MT.DataSourceKey = 2
            
    LEFT OUTER JOIN sap.DimPlants P 
        on  ifnull(mseg.werks,'UNDF') = P.PlantCode
        AND P.DataSourceKey = 2
        
    LEFT OUTER JOIN sap.DimMaterials pp
        on IfNULL(mseg.MATNR,'UNDF') = PP.MaterialCode
        and ifnull(mseg.werks,'UNDF') = P.PlantCode            
        AND P.PlantKey = PP.PlantKey
        AND PP.DataSourceKey = 2
    
    LEFT OUTER JOIN sap.DimInventoryLocations  L
    ON IFNULL(mseg.lgort ,'UNDF') = L.InventoryLocationCode
       AND ifnull(mseg.werks,'') =  L.PlantCode
            AND L.DataSourceKey = 1
            
    LEFT OUTER JOIN sap.DimInventoryTypes I 
        ON IfNULL(mseg.insmk,'UNDF') = I.InventoryTypeCode
        AND I.DataSourceKey = 2
    
    LEFT OUTER JOIN sap.DimSpecialStocks SS
        ON IFNULL( mseg.sobkz,'-') = SS.SpecialStocksCode
        AND SS.DataSourceKey = 2
                
    LEFT OUTER JOIN sap.DimAML A
        on IFNULL(mseg.ematn ,'UNDF') = A.AMLReference 
            AND A.PlantKey = P.PlantKey 
            AND A.DataSourceKey = 2
    
    LEFT OUTER JOIN sap.DimReasonTypes R        
        ON ifnull( cast(try_to_number ( mseg.grund )  as string),  IFNULL(mseg.grund , 'UNDF') ) = R.ReasonTypeCode 
            AND R.MovementTypeKey = MT.Movementtypekey
            AND R.DataSourceKey = 2
            
    LEFT OUTER JOIN sap.DimSuppliers S 
        on IFNULL( mseg.lifnr,'UNDF') = S.SupplierCode
            AND IFNULL( lfa1.ktokk , 'UNDF')   = S.SupplierTypeCode
            AND S.DataSourceKey = 2
            
    LEFT OUTER JOIN sap.DimExchangeRates ER
        ON ifnull(mseg.waers,'') = ER.currencycode
        and ER.ToCurrencyCode = 'USD'
        and ifnull(to_date(mkpf.cpudt, 'YYYYMMDD'),'1900-01-01') = ER.EffectiveFromDateKey
        and ER.DataSourceKey = 2
        
    LEFT OUTER JOIN sap.DimCurrencyDecimalPlaces  DCDP
        ON DCDP.CurrencyCode = ifnull(mseg.waers,'')
        and DCDP.DataSourceKey = 2
        and DCDP.ExponentFactor > 0 ;