create or replace view V_FACTPURCHASEORDERS(
	DATASOURCEKEY,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	PURCHASEDOCUMENTTYPEKEY,
	PURCHASEDOCUMENTCATEGORYKEY,
	SUPPLIERKEY,
	SUPPLIERPLANTKEY,
	SELLERKEY,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	PURCHASEORDERCREATEDDATEKEY,
	PUBLISHEDDATEKEY,
	PLANTKEY,
	MATERIALKEY,
	CUMULATIVEQTYRECONCILEDATEKEY,
	PURCHASEITEMCATEGORYKEY,
	SPECIALSTOCKSKEY,
	MANUFACTURERKEY,
	AMLKEY,
	BUYERKEY,
	EXCHANGERATEKEY,
	COMPANYORGANIZATIONCODE,
	PURCHASINGORGANIZATIONCODE,
	CURRENCYCODE,
	DELETEFLAG,
	SISEDIFLAG,
	PURCHASEQUANTITY,
	NETPRICE,
	PRICEUNIT,
	UNITPRICE,
	DELIVERYCOMPLETEFLAG,
	CUMULATIVEQUANTITY,
	ACCOUNTASSIGNMENT,
	NONVALUEDFLAG,
	LASTTRANSMISSIONDATEKEY,
	LASTTRANSMISSIONNUMBER,
	ORDERUNITOFMEASURECODE,
	BASEUNITOFMEASURE,
	PURCHASEORDERBLOCKED,
	NUMBEROFINFORMATIONRECORD,
	UNITPRICEBASEUOM,
	CANCELLATIONLEADTIME,
	PAYMENTTERMKEY,
	FIRMZONE,
	TRADEOFFZONE,
	DUNSNUMBER,
	CONDITIONRECORD,
	PROCEDURERECORD,
	INCOTERMS1,
	INCOTERMS2,
	ITEMCOMMENT,
	RECEIVINGSTORAGELOCATION,
	MATERIALGROUP,
	PROFITCENTER,
	NETORDER,
	EXCHANGERATE,
	PROFITCENTER2,
	RN,
	POREMINDER1,
	POREMINDER2,
	MANUFACTURERPARTKEY
) as
SELECT 
    *
FROM     
    (
      SELECT
            1 as DataSourceKey
          , PurchaseDocumentNumber
          , PurchaseDocumentItem
          , PURCHASEDOCUMENTTYPEKEY 
          , PURCHASEDOCUMENTCATEGORYKEY
          , SUPPLIERKEY
          , SUPPLIERPLANTKEY 
          , SELLERKEY
          , EFFECTIVEFROMDATEKEY
          , EFFECTIVETODATEKEY 
          , PURCHASEORDERCREATEDDATEKEY
          , PUBLISHEDDATEKEY
          , PLANTKEY 
          , MATERIALKEY 
          , CUMULATIVEQTYRECONCILEDATEKEY
          , PURCHASEITEMCATEGORYKEY 
          , SPECIALSTOCKSKEY 
          , MANUFACTURERKEY
          , AMLKEY
          , BUYERKEY
          , EXCHANGERATEKEY
          , COMPANYORGANIZATIONCODE
          , PURCHASINGORGANIZATIONCODE
          , CURRENCYCODE
          , DELETEFLAG 
          , SISEDIFLAG 
          , PURCHASEQUANTITY
          , NETPRICE
          , PRICEUNIT
          , UnitPrice
          , DELIVERYCOMPLETEFLAG
          , CUMULATIVEQUANTITY 
          , ACCOUNTASSIGNMENT 
          , NONVALUEDFLAG 
          , LASTTRANSMISSIONDATEKEY
          , LASTTRANSMISSIONNUMBER 
          , ORDERUNITOFMEASURECODE   
          , BASEUNITOFMEASURE 
          , PURCHASEORDERBLOCKED
          , NUMBEROFINFORMATIONRECORD
          , UNITPRICEBASEUOM  --hardcoded because we do not have MARC **********
          , CANCELLATIONLEADTIME
          , PAYMENTTERMKEY
          , FIRMZONE 
          , TRADEOFFZONE
          , DUNSNUMBER
          , CONDITIONRECORD
          , PROCEDURERECORD
          , INCOTERMS1        
          , INCOTERMS2
          , ITEMCOMMENT
          , RECEIVINGSTORAGELOCATION
          , MATERIALGROUP
          , PROFITCENTER    
          , NETORDER 
          , EXCHANGERATE
          , PROFITCENTER2
          , row_number() over (partition by PurchaseDocumentNumber, PurchaseDocumentItem order by PurchaseDocumentNumber ) RN
          ,POReminder1
          ,POReminder2
          ,ManufacturerPartKey
      FROM 
          conformed.v_ecc_ha_FactPurchaseOrders
      
      UNION ALL 
      
      SELECT
            2 as DataSourceKey
          , PurchaseDocumentNumber
          , PurchaseDocumentItem
          , PURCHASEDOCUMENTTYPEKEY 
          , PURCHASEDOCUMENTCATEGORYKEY
          , SUPPLIERKEY
          , SUPPLIERPLANTKEY 
          , SELLERKEY
          , EFFECTIVEFROMDATEKEY
          , EFFECTIVETODATEKEY 
          , PURCHASEORDERCREATEDDATEKEY
          , PUBLISHEDDATEKEY
          , PLANTKEY 
          , MATERIALKEY 
          , CUMULATIVEQTYRECONCILEDATEKEY
          , PURCHASEITEMCATEGORYKEY 
          , SPECIALSTOCKSKEY 
          , MANUFACTURERKEY
          , AMLKEY
          , BUYERKEY
          , EXCHANGERATEKEY
          , COMPANYORGANIZATIONCODE
          , PURCHASINGORGANIZATIONCODE
          , CURRENCYCODE
          , DELETEFLAG 
          , SISEDIFLAG 
          , PURCHASEQUANTITY
          , NETPRICE
          , PRICEUNIT
          , UnitPrice
          , DELIVERYCOMPLETEFLAG
          , CUMULATIVEQUANTITY 
          , ACCOUNTASSIGNMENT 
          , NONVALUEDFLAG 
          , LASTTRANSMISSIONDATEKEY
          , LASTTRANSMISSIONNUMBER 
          , ORDERUNITOFMEASURECODE   
          , BASEUNITOFMEASURE 
          , PURCHASEORDERBLOCKED
          , NUMBEROFINFORMATIONRECORD
          , UNITPRICEBASEUOM  --hardcoded because we do not have MARC **********
          , CANCELLATIONLEADTIME
          , PAYMENTTERMKEY
          , FIRMZONE 
          , TRADEOFFZONE
          , DUNSNUMBER
          , CONDITIONRECORD
          , PROCEDURERECORD
          , INCOTERMS1        
          , INCOTERMS2
          , ITEMCOMMENT
          , RECEIVINGSTORAGELOCATION
          , MATERIALGROUP
          , PROFITCENTER    
          , NETORDER 
          , EXCHANGERATE
          , PROFITCENTER2
          , row_number() over (partition by PurchaseDocumentNumber, PurchaseDocumentItem order by PurchaseDocumentNumber ) RN
          ,POReminder1
          ,POReminder2
          , ManufacturerPartKey
      FROM 
          conformed.v_hcc_ha_FactPurchaseOrders      
	  
	  union all
	  
	  SELECT
            5 as DataSourceKey
          , PurchaseDocumentNumber
          , PurchaseDocumentItem
          , PURCHASEDOCUMENTTYPEKEY 
          , PURCHASEDOCUMENTCATEGORYKEY
          , SUPPLIERKEY
          , SUPPLIERPLANTKEY 
          , SELLERKEY
          , EFFECTIVEFROMDATEKEY
          , EFFECTIVETODATEKEY 
          , PURCHASEORDERCREATEDDATEKEY
          , PUBLISHEDDATEKEY
          , PLANTKEY 
          , MATERIALKEY 
          , CUMULATIVEQTYRECONCILEDATEKEY
          , PURCHASEITEMCATEGORYKEY 
          , SPECIALSTOCKSKEY 
          , MANUFACTURERKEY
          , AMLKEY
          , BUYERKEY
          , EXCHANGERATEKEY
          , COMPANYORGANIZATIONCODE
          , PURCHASINGORGANIZATIONCODE
          , CURRENCYCODE
          , DELETEFLAG 
          , SISEDIFLAG 
          , PURCHASEQUANTITY
          , NETPRICE
          , PRICEUNIT
          , UnitPrice
          , DELIVERYCOMPLETEFLAG
          , CUMULATIVEQUANTITY 
          , ACCOUNTASSIGNMENT 
          , NONVALUEDFLAG 
          , LASTTRANSMISSIONDATEKEY
          , LASTTRANSMISSIONNUMBER 
          , ORDERUNITOFMEASURECODE   
          , BASEUNITOFMEASURE 
          , PURCHASEORDERBLOCKED
          , NUMBEROFINFORMATIONRECORD
          , UNITPRICEBASEUOM  --hardcoded because we do not have MARC **********
          , CANCELLATIONLEADTIME
          , PAYMENTTERMKEY
          , FIRMZONE 
          , TRADEOFFZONE
          , DUNSNUMBER
          , CONDITIONRECORD
          , PROCEDURERECORD
          , INCOTERMS1        
          , INCOTERMS2
          , ITEMCOMMENT
          , RECEIVINGSTORAGELOCATION
          , MATERIALGROUP
          , PROFITCENTER    
          , NETORDER 
          , EXCHANGERATE
          , PROFITCENTER2
          , row_number() over (partition by PurchaseDocumentNumber, PurchaseDocumentItem order by PurchaseDocumentNumber ) RN
          ,POReminder1
          ,POReminder2
          ,ManufacturerPartKey
      FROM 
          conformed.v_jps_ha_FactPurchaseOrders
	  
	  union all
	  
	  SELECT
            4 as DataSourceKey
          , PurchaseDocumentNumber
          , PurchaseDocumentItem
          , PURCHASEDOCUMENTTYPEKEY 
          , PURCHASEDOCUMENTCATEGORYKEY
          , SUPPLIERKEY
          , SUPPLIERPLANTKEY 
          , SELLERKEY
          , EFFECTIVEFROMDATEKEY
          , EFFECTIVETODATEKEY 
          , PURCHASEORDERCREATEDDATEKEY
          , PUBLISHEDDATEKEY
          , PLANTKEY 
          , MATERIALKEY 
          , CUMULATIVEQTYRECONCILEDATEKEY
          , PURCHASEITEMCATEGORYKEY 
          , SPECIALSTOCKSKEY 
          , MANUFACTURERKEY
          , AMLKEY
          , BUYERKEY
          , EXCHANGERATEKEY
          , COMPANYORGANIZATIONCODE
          , PURCHASINGORGANIZATIONCODE
          , CURRENCYCODE
          , DELETEFLAG 
          , SISEDIFLAG 
          , PURCHASEQUANTITY
          , NETPRICE
          , PRICEUNIT
          , UnitPrice
          , DELIVERYCOMPLETEFLAG
          , CUMULATIVEQUANTITY 
          , ACCOUNTASSIGNMENT 
          , NONVALUEDFLAG 
          , LASTTRANSMISSIONDATEKEY
          , LASTTRANSMISSIONNUMBER 
          , ORDERUNITOFMEASURECODE   
          , BASEUNITOFMEASURE 
          , PURCHASEORDERBLOCKED
          , NUMBEROFINFORMATIONRECORD
          , UNITPRICEBASEUOM  --hardcoded because we do not have MARC **********
          , CANCELLATIONLEADTIME
          , PAYMENTTERMKEY
          , FIRMZONE 
          , TRADEOFFZONE
          , DUNSNUMBER
          , CONDITIONRECORD
          , PROCEDURERECORD
          , INCOTERMS1        
          , INCOTERMS2
          , ITEMCOMMENT
          , RECEIVINGSTORAGELOCATION
          , MATERIALGROUP
          , PROFITCENTER    
          , NETORDER 
          , EXCHANGERATE
          , PROFITCENTER2
          , row_number() over (partition by PurchaseDocumentNumber, PurchaseDocumentItem order by PurchaseDocumentNumber ) RN
          ,POReminder1
          ,POReminder2
          ,ManufacturerPartKey
      FROM 
          conformed.v_pla_ha_FactPurchaseOrders

    ) q
WHERE 
    q.rn = 1                      ;