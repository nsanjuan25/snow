create or replace view V_SAP_PURCHASEHISTORY(
	DATASOURCEKEY,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	SEQNUMBEROFPURCHASEDOCUMENT,
	PURCHASEHISTORYTYPECODE,
	MATERIALDOCYEAR,
	MATERIALDOCUMENTNUMBER,
	MATERIALDOCUMENTITEM,
	POHISTORYCATEGORY,
	MOVEMENTTYPECODE,
	POSTINGDTS,
	QUANTITY1,
	AMOUNTINLOCALCURRENCY,
	AMOUNTINDOCUMENTCURRENCY,
	DOCUMENTCURRENCYCODE,
	GRLRACCOUNTCLEARINGVALUE,
	GOODSRECEIPTBLOCKEDSTOCK,
	QTYINGRBLOCKEDSTOCK,
	DEBITCREDITINDICATOR,
	DELIVERYCOMPLETEFLAG,
	REFERENCEDOCUMENTNUMBER,
	FISCALYEAR,
	DOCUMENTNUMBEROFAREFERENCEDOCUMENT,
	REFERENCEDOCUMENTITEM,
	REASONFORMOVEMENT,
	ACCOUNTINGDOCENTRYDATE,
	TIMEOFENTRY,
	INVOICEVALUELOCALCURR,
	SHIPPINGCOMPLIANCECODE,
	INVOICEVALUEFOREIGNCURR,
	SITEPARTCODE,
	SITECODE,
	SEQNUMBERVENDORCONF,
	NUMBEROFTHEDOCUMENTCONDITION,
	TAXONSALESPURCHASESCODE,
	AMLREFERENCE,
	LOCALCURRENCYCODE,
	QUANTITY2,
	BATCHNUMBER,
	DSCREATEDTS,
	DSCREATEUSER,
	PURCHASEUNITOFMEASUREDSCODE,
	BASEUNITOFMEASURE,
	UPDATED_ON
) as 
    
    SELECT
        2 AS DataSourceKey
        , * 
    FROM 
        CONFORMED.V_HCC_SAP_PURCHASEHISTORY 
    
    union all 
    
    SELECT
          1 AS DataSourceKey
        , * 
    FROM 
        CONFORMED.V_ECC_SAP_PURCHASEHISTORY

    union all 
    
    SELECT
          4 AS DataSourceKey
        , * 
    FROM 
        CONFORMED.V_PLA_SAP_PURCHASEHISTORY				
    union all 
    
    SELECT
          5 AS DataSourceKey
        , * 
    FROM 
        CONFORMED.V_JPS_SAP_PURCHASEHISTORY		;