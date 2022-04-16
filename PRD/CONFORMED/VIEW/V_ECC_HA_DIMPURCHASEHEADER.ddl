create or replace view V_ECC_HA_DIMPURCHASEHEADER(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTTYPECODE,
	PURCHASEDOCUMENTCATEGORYCODE,
	COMPANYORGANIZATIONCODE,
	PURCHASINGORGANIZATIONCODE,
	SUPPLIERCORPORATIONDSCODE,
	PAYMENTTERMS,
	EFFECTIVEFROMDTS,
	EFFECTIVETODTS,
	SUPPLIERCONTACT,
	SUPPLIERPHONENUMBER,
	SUPPLIERSITECODE,
	CONDITIONRECORD,
	PROCEDURERECORD,
	INCOTERMS1,
	INCOTERMS2,
	BUYERCODE,
	CURRENCYCODE,
	EXCHANGERATE,
	DELETEFLAG,
	DSCREATEUSER,
	DSCREATEDTS,
	PUBLISHEDDTS,
	UPDATED_ON
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.Dimselleres
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-01-23      Venkata         Initial Revision
  */

select ekko.ebeln as PurchaseDocumentNumber,
    ekko.bsart as PurchaseDocumentTypeCode,
    ekko.bstyp as PurchaseDocumentCategoryCode,
    ekko.bukrs as CompanyOrganizationCode,
    ekko.ekorg as PurchasingOrganizationCode,
    ekko.lifnr as SupplierCorporationDSCode,
    ekko.zterm as PaymentTerms,
    ekko.kdatb as EffectiveFromDTS,
    ekko.kdate as EffectiveToDTS,
    ekko.verkf as SupplierContact,
    ekko.telf1 as SupplierPhoneNumber,
    ekko.reswk as SupplierSiteCode,
    ekko.knumv as ConditionRecord,
    ekko.kalsm as ProcedureRecord,
    ekko.inco1 as IncoTerms1,
    ekko.inco2 as IncoTerms2,
    ekko.ekgrp as BuyerCode,
    ekko.waers as CurrencyCode,
    ekko.wkurs as ExchangeRate,
  --if(loekz is NULL or loekz='', 0 , 1 ) 
    0 as  DeleteFlag,
    ekko.ernam as DSCreateUser,
    ekko.aedat as DSCreateDTS,
    ekko.bedat as PublishedDTS,
    current_timestamp as updated_on
    
 from CONFORMED.ECC_HA_EKKO ekko;