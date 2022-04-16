create or replace view V_PLA_SAP_PURCHASEHISTORY(
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
2021-10-08      Jagan                  Initial Revision
*/
    SELECT 
        PLA_HA_EKBE.ebeln              as       PurchaseDocumentNumber                 , 
        PLA_HA_EKBE.ebelp              as       PurchaseDocumentItem                   , 
        PLA_HA_EKBE.zekkn              as       SeqNumberofPurchaseDocument            , 
        PLA_HA_EKBE.vgabe              as       PurchaseHistoryTypeCode                , 
        PLA_HA_EKBE.gjahr              as       MaterialDocYear                        , 
        PLA_HA_EKBE.belnr              as       MaterialDocumentNumber                 , 
        PLA_HA_EKBE.buzei              as       MaterialDocumentItem                   , 
        PLA_HA_EKBE.bewtp              as       POHistoryCategory                      , 
        ifnull(PLA_HA_EKBE.bwart,'')   as       MovementTypeCode                       , 
        try_to_date(PLA_HA_EKBE.budat, 'YYYYMMDD')  as       PostingDTS                             , 
        PLA_HA_EKBE.menge              as       Quantity1                              , 
        case when PLA_HA_TCURX.currkey = PLA_HA_EKBE.hswae then PLA_HA_EKBE.dmbtr * power(10, (2 - currdec)) else PLA_HA_EKBE.dmbtr end as AmountInLocalCurrency, 
        case when PLA_HA_TCURX.currkey = PLA_HA_EKBE.waers then PLA_HA_EKBE.wrbtr * power(10, (2 - currdec)) else PLA_HA_EKBE.wrbtr end as AmountInDocumentCurrency, 
        PLA_HA_EKBE.waers              as       DocumentCurrencyCode                   , 
        case when PLA_HA_TCURX.currkey = PLA_HA_EKBE.waers then PLA_HA_EKBE.arewr * power(10, (2 - currdec)) else PLA_HA_EKBE.arewr end as GrlrAccountClearingValue, 
        PLA_HA_EKBE.wesbs              as       GoodsReceiptBlockedStock               , 
        PLA_HA_EKBE.bpwes              as       QtyInGrBlockedStock                    , 
        IFF(PLA_HA_EKBE.shkzg='H','+','-')      as        DebitCreditIndicator                  , 
        PLA_HA_EKBE.elikz              as       DeliveryCompleteFlag                   , 
        PLA_HA_EKBE.xblnr              as       ReferenceDocumentNumber                , 
        PLA_HA_EKBE.lfgja              as       FiscalYear                             , 
        PLA_HA_EKBE.lfbnr              as       DocumentNumberOfAReferenceDocument     , 
        PLA_HA_EKBE.lfpos              as       ReferenceDocumentItem                  , 
        PLA_HA_EKBE.grund              as       ReasonForMovement                      , 
        try_to_date(PLA_HA_EKBE.cpudt, 'YYYYMMDD' )           as       AccountingDocEntryDate                 , 
        PLA_HA_EKBE.cputm              as       TimeOfEntry                            , 
        case when PLA_HA_TCURX.currkey = PLA_HA_EKBE.waers then PLA_HA_EKBE.reewr * power(10, (2 - currdec)) else PLA_HA_EKBE.reewr end as InvoiceValueLocalCurr, 
        PLA_HA_EKBE.evere              as       ShippingComplianceCode                 , 
        case when PLA_HA_TCURX.currkey = PLA_HA_EKBE.waers then PLA_HA_EKBE.refwr * power(10, (2 - currdec)) else PLA_HA_EKBE.refwr end as InvoiceValueForeignCurr, 
        case when NOT(PLA_HA_EKBE.matnr is null or PLA_HA_EKBE.matnr = '') then PLA_HA_EKBE.matnr else PLA_HA_EKPO.matnr end as SitePartCode, 
        case when NOT(PLA_HA_EKBE.werks is null or PLA_HA_EKBE.matnr = '') then PLA_HA_EKBE.werks else PLA_HA_EKPO.werks end as SiteCode, 
        PLA_HA_EKBE.etens              as                  SeqNumberVendorConf     , 
        PLA_HA_EKBE.knumv              as                       NumberOfTheDocumentCondition, 
        PLA_HA_EKBE.mwskz              as                       TaxOnSalesPurchasesCode, 
        case when NOT(PLA_HA_EKBE.ematn is null or PLA_HA_EKBE.ematn = '') then PLA_HA_EKBE.ematn else PLA_HA_EKPO.ematn end as  AMLReference, 
        PLA_HA_EKBE.hswae              as  LocalCurrencyCode, 
        PLA_HA_EKBE.bamng              as  Quantity2, 
        PLA_HA_EKBE.charg              as  BatchNumber, 
        try_to_date(PLA_HA_EKBE.bldat ,'YYYYMMDD' )              as  DSCreateDTS, 
        PLA_HA_EKBE.ernam              as  DSCreateUser, 
        PLA_HA_EKPO.meins              as PurchaseUnitofMeasureDSCode, 
        PLA_HA_EKPO.lmein              as BaseUnitOfMeasure, 
        PLA_HA_EKBE.FRMW_EXTRACTED_ON  as updated_on 
FROM  
    CONFORMED.PLA_HA_EKBE 
INNER JOIN  
    CONFORMED.PLA_HA_EKPO 
	on  PLA_HA_EKBE.EBELN = PLA_HA_EKPO.EBELN 
    and PLA_HA_EKBE.EBELP = PLA_HA_EKPO.EBELP 
LEFT JOIN  
    CONFORMED.PLA_HA_TCURX 
	on  PLA_HA_EKBE.waers = PLA_HA_TCURX.currkey 
WHERE
    NOT(PLA_HA_EKBE.WERKS is null or PLA_HA_EKBE.WERKS = '') 
    and NOT(PLA_HA_EKPO.WERKS is null or PLA_HA_EKPO.WERKS = '');