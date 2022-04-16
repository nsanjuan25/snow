create or replace view V_JPS_SAP_PURCHASEHISTORY(
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
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.FACTPURCHASEHISTORY
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-09-27      Jagan                  Initial Revision
*/
    SELECT 
        JPS_HA_EKBE.ebeln              as       PurchaseDocumentNumber                 , 
        JPS_HA_EKBE.ebelp              as       PurchaseDocumentItem                   , 
        JPS_HA_EKBE.zekkn              as       SeqNumberofPurchaseDocument            , 
        JPS_HA_EKBE.vgabe              as       PurchaseHistoryTypeCode                , 
        JPS_HA_EKBE.gjahr              as       MaterialDocYear                        , 
        JPS_HA_EKBE.belnr              as       MaterialDocumentNumber                 , 
        JPS_HA_EKBE.buzei              as       MaterialDocumentItem                   , 
        JPS_HA_EKBE.bewtp              as       POHistoryCategory                      , 
        ifnull(JPS_HA_EKBE.bwart,'')   as       MovementTypeCode                       , 
        try_to_date(JPS_HA_EKBE.budat, 'YYYYMMDD')  as       PostingDTS                             , 
        JPS_HA_EKBE.menge              as       Quantity1                              , 
        case when JPS_HA_TCURX.currkey = JPS_HA_EKBE.hswae then JPS_HA_EKBE.dmbtr * power(10, (2 - currdec)) else JPS_HA_EKBE.dmbtr end as AmountInLocalCurrency, 
        case when JPS_HA_TCURX.currkey = JPS_HA_EKBE.waers then JPS_HA_EKBE.wrbtr * power(10, (2 - currdec)) else JPS_HA_EKBE.wrbtr end as AmountInDocumentCurrency, 
        JPS_HA_EKBE.waers              as       DocumentCurrencyCode                   , 
        case when JPS_HA_TCURX.currkey = JPS_HA_EKBE.waers then JPS_HA_EKBE.arewr * power(10, (2 - currdec)) else JPS_HA_EKBE.arewr end as GrlrAccountClearingValue, 
        JPS_HA_EKBE.wesbs              as       GoodsReceiptBlockedStock               , 
        JPS_HA_EKBE.bpwes              as       QtyInGrBlockedStock                    , 
        IFF(JPS_HA_EKBE.shkzg='H','+','-')      as        DebitCreditIndicator                  , 
        JPS_HA_EKBE.elikz              as       DeliveryCompleteFlag                   , 
        JPS_HA_EKBE.xblnr              as       ReferenceDocumentNumber                , 
        JPS_HA_EKBE.lfgja              as       FiscalYear                             , 
        JPS_HA_EKBE.lfbnr              as       DocumentNumberOfAReferenceDocument     , 
        JPS_HA_EKBE.lfpos              as       ReferenceDocumentItem                  , 
        JPS_HA_EKBE.grund              as       ReasonForMovement                      , 
        try_to_date(JPS_HA_EKBE.cpudt, 'YYYYMMDD' )           as       AccountingDocEntryDate                 , 
        JPS_HA_EKBE.cputm              as       TimeOfEntry                            , 
        case when JPS_HA_TCURX.currkey = JPS_HA_EKBE.waers then JPS_HA_EKBE.reewr * power(10, (2 - currdec)) else JPS_HA_EKBE.reewr end as InvoiceValueLocalCurr, 
        JPS_HA_EKBE.evere              as       ShippingComplianceCode                 , 
        case when JPS_HA_TCURX.currkey = JPS_HA_EKBE.waers then JPS_HA_EKBE.refwr * power(10, (2 - currdec)) else JPS_HA_EKBE.refwr end as InvoiceValueForeignCurr, 
        case when NOT(JPS_HA_EKBE.matnr is null or JPS_HA_EKBE.matnr = '') then JPS_HA_EKBE.matnr else JPS_HA_EKPO.matnr end as SitePartCode, 
        case when NOT(JPS_HA_EKBE.werks is null or JPS_HA_EKBE.matnr = '') then JPS_HA_EKBE.werks else JPS_HA_EKPO.werks end as SiteCode, 
        JPS_HA_EKBE.etens              as                  SeqNumberVendorConf     , 
        JPS_HA_EKBE.knumv              as                       NumberOfTheDocumentCondition, 
        JPS_HA_EKBE.mwskz              as                       TaxOnSalesPurchasesCode, 
        case when NOT(JPS_HA_EKBE.ematn is null or JPS_HA_EKBE.ematn = '') then JPS_HA_EKBE.ematn else JPS_HA_EKPO.ematn end as  AMLReference, 
        JPS_HA_EKBE.hswae              as  LocalCurrencyCode, 
        JPS_HA_EKBE.bamng              as  Quantity2, 
        JPS_HA_EKBE.charg              as  BatchNumber, 
        try_to_date(JPS_HA_EKBE.bldat ,'YYYYMMDD' )              as  DSCreateDTS, 
        JPS_HA_EKBE.ernam              as  DSCreateUser, 
        JPS_HA_EKPO.meins              as PurchaseUnitofMeasureDSCode, 
        JPS_HA_EKPO.lmein              as BaseUnitOfMeasure, 
        JPS_HA_EKBE.FRMW_EXTRACTED_ON  as updated_on 
FROM  
    JPS_HA_EKBE 
INNER JOIN  
    JPS_HA_EKPO 
	on  JPS_HA_EKBE.EBELN = JPS_HA_EKPO.EBELN 
    and JPS_HA_EKBE.EBELP = JPS_HA_EKPO.EBELP 
LEFT JOIN  
    JPS_HA_TCURX 
	on  JPS_HA_EKBE.waers = JPS_HA_TCURX.currkey 
WHERE
    NOT(JPS_HA_EKBE.WERKS is null or JPS_HA_EKBE.WERKS = '') 
    and NOT(JPS_HA_EKPO.WERKS is null or JPS_HA_EKPO.WERKS = '');