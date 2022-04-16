create or replace view V_HCC_HA_DIMMANUFACTURERS(
	MANUFACTURERCODE,
	CORPORATIONID,
	MANUFACTURERTYPECODE,
	GLOBALMANUFACTURERNAME,
	LOCALMANUFACTURERNAME,
	LOCALMANUFACTURERNAME2,
	LOCALMANUFACTURERNAME3,
	LOCALMANUFACTURERNAME4,
	ADDRESS1,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	POSTALCODE,
	PAYMENTTERMS,
	ORGANIZATIONCODE,
	ORGANIZATIONTYPECODE,
	ACCOUNTINGMANUFACTURERCODE,
	DELETEFLAG,
	MINORITYINDICATOR,
	MINORITYTEXT,
	CERTIFICATIONDATE,
	VENDORMASTERPAYMENTTERMS,
	VENDORCLASSIFICATION,
	DUNSNUMBER
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimManufacturers
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Juan Cedeno             Initial Revision
*/                         
SELECT 
    IFNULL(lfa1.lifnr ,'') AS  ManufacturerCode
  , 0 AS CorporationID
  , IFNULL(lfa1.ktokk ,'') 	AS ManufacturerTypeCode
  , 'UNDF' AS GlobalManufacturerName
  , IFNULL(lfa1.name1 ,'')  AS LocalManufacturerName
  , IFNULL(lfa1.name2 ,'')  AS LocalManufacturerName2  
  , IFNULL(lfa1.name3 ,'')  AS LocalManufacturerName3  
  , IFNULL(lfa1.name4 ,'')  AS LocalManufacturerName4    
  , IFNULL(lfa1.stras ,'') 	as Address1 
  , IFNULL(lfa1.ort01 ,'') 	AS City
  , IFNULL(lfa1.regio ,'') 	AS StateProvince
  , IFNULL(lfa1.land1 ,'') 	AS Country
  , IFNULL(lfa1.pstlz ,'') 	AS PostalCode
  , ''                      AS PaymentTerms
  , ''                      AS OrganizationCode
  , ''                      AS OrganizationTypeCode
  , ''                      AS AccountingManufacturerCode                        
  , CASE WHEN lfa1.loevm = 'X' THEN 'TRUE' ELSE 'FALSE' END AS DeleteFlag
  , ''                                       AS MinorityIndicator
  , ''                                       AS MinorityText
  , ''                                       AS CertificationDate
  , IFNULL(lfm1.zterm ,'')                   AS VendorMasterPaymentTerms
  , ''                                       AS VendorClassification  
  , ''                                       AS DUNSNumber
FROM 
    conformed.HCC_HA_LFA1 as lfa1 
    LEFT OUTER JOIN conformed.HCC_HA_LFM1 as lfm1 ON lfa1.lifnr = lfm1.lifnr
WHERE 
    lfa1.ktokk  like '%MF%';