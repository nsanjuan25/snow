create or replace view V_HCC_DIMSUPPLIERCOMPANIES(
	SUPPLIERCODE,
	CORPORATIONID,
	COMPANYORGANIZATIONCODE,
	SUPPLIERTYPECODE,
	SUPPLIERTYPE,
	SUPPLIERCONTRACT,
	VIAFLAG,
	DATASOURCEKEY,
	GLOBALSUPPLIERNAME,
	LOCALSUPPLIERNAME,
	LOCALSUPPLIERNAME2,
	LOCALSUPPLIERNAME3,
	LOCALSUPPLIERNAME4,
	ADDRESS1,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	POSTALCODE,
	PAYMENTTERMS,
	ORGANIZATIONCODE,
	ORGANIZATIONTYPECODE,
	ACCOUNTINGSUPPLIERCODE,
	DELETEFLAG,
	MINORITYINDICATOR,
	MINORITYTEXT,
	CERTIFICATIONDATE,
	VENDORMASTERPAYMENTTERMS,
	VENDORCLASSIFICATION,
	SRCLASTMODIFIEDDATE,
	DUNSNUMBER
) as 
/* 
Description         : View used to populate No Consigned Historical Spend

Start Revision History            
-----------------------------------------------------------------------------------------------
Date         Developer           Revision Description
----------    --------------      -------------------------------------------------------------

2021-03-11	  Sridhar K	 InitialVersion
2022-02-23    Carlos Carrillo   Adding missing condition on join LFA1 AND LFM1
-----------------------------------------------------------------------------------------------
End   Revision   History
*/



    SELECT DISTINCT
   
    RTRIM(UPPER(ESV.lifnr))     AS SupplierCode
  , 0							AS CorporationID 
  , RTRIM(UPPER( IFNULL( LFB.BUKRS , '' ))) AS CompanyOrganizationCode
  , RTRIM(UPPER(ESV.ktokk))     AS SupplierTypeCode
  , 'UNDF'                      AS SupplierType
  , 'UNDF'                      AS SupplierContract
  , ''                          AS VIAFlag
  , 2							AS  DataSourceKey 
  , 'UNDF'                      AS  GlobalSupplierName 
  , RTRIM(ESV.name1)            AS  LocalSupplierName 
  , RTRIM(ESV.name2)            AS  LocalSupplierName2 
  , RTRIM(ESV.name3)            AS  LocalSupplierName3 
  , RTRIM(ESV.name4)            AS  LocalSupplierName4 
  , RTRIM(ESV.stras)            AS  Address1 
  , RTRIM(ESV.ort01)            AS  City 
  , RTRIM(ESV.regio)            AS  StateProvince 
  , RTRIM(ESV.land1)            AS  Country 
  , RTRIM(ESV.pstlz)            AS  PostalCode 
  , IFNULL(RTRIM(LFM.ZTERM),'') AS  PaymentTerms 
  , ''                          AS  OrganizationCode 
  , ''                          AS  OrganizationTypeCode 
  , ''                          AS  AccountingSupplierCode 
  , CASE WHEN ESV.loevm = 'X' THEN 1 ELSE 0 END AS  DeleteFlag 
  , ''                          AS  MinorityIndicator 
  , ''                          AS  MinorityText 
  , ''                          AS  CertificationDate 
  , IFNULL(RTRIM(LFB.ZTERM),'') AS  VendorMasterPaymentTerms 
  , ''                          AS  VendorClassification 
  , IFNULL(LFB.SNFLK_UPDATEDON,current_date())              AS  SrcLastModifiedDate 
  , ''                          AS DUNSNumber 
   
FROM 
    CONFORMED.HCC_HA_LFA1 AS ESV
	LEFT JOIN CONFORMED.HCC_HA_LFB1 AS LFB ON ESV.lifnr = LFB.lifnr 
    LEFT JOIN CONFORMED.HCC_HA_LFM1 AS LFM ON ESV.lifnr = LFM.lifnr 
                                           AND LFB.BUKRS = LFM.EKORG
WHERE 
	ESV.ktokk <> 'zmfg';