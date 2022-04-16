create or replace view V_DIMSHIPTOPARTIES(
	SHIPTOPARTYCODE,
	SHIPTOPARTYTYPECODE,
	CORPORATIONID,
	GLOBALSHIPTOPARTYNAME,
	LOCALSHIPTOPARTYNAME,
	LOCALSHIPTOPARTYNAME2,
	LOCALSHIPTOPARTYNAME3,
	LOCALSHIPTOPARTYNAME4,
	ADDRESS1,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	POSTALCODE,
	SRCLASTMODIFIEDDATE,
	PAYMENTTERMS,
	ORGANIZATIONCODE,
	ORGANIZATIONTYPECODE,
	ACCOUNTINGSHIPTOPARTYCODE,
	DELETEFLAG,
	MINORITYINDICATOR,
	MINORITYTEXT,
	CERTIFICATIONDATE,
	VENDORMASTERPAYMENTTERMS,
	VENDORCLASSIFICATION,
	DATASOURCEKEY,
	DUNSNUMBER,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimShipToParty
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-24      Carlos Carrillo         Initial Revision
  */

  
SELECT 
	      ShipToPartyCode 
		, ShipToPartyTypeCode	
		, CorporationID
	    , GlobalShipToPartyName
	    , LocalShipToPartyName
	    , LocalShipToPartyName2	
	    , LocalShipToPartyName3
	    , LocalShipToPartyName4
	    , Address1
	    , City	
	    , StateProvince	
	    , Country
	    , PostalCode
	    , SrcLastModifiedDate	
	    , PaymentTerms
	    , OrganizationCode
	    , OrganizationTypeCode
	    , AccountingShipToPartyCode
	    , DeleteFlag 
	    , MinorityIndicator
	    , MinorityText
	    , CertificationDate
	    , VendorMasterPaymentTerms
	    , VendorClassification
	    , DataSourceKey
		, DUNSNumber
	    , HASH_VALUE
		
    FROM 
        conformed.V_ECC_HA_DIMSHIPTOPARTIES;