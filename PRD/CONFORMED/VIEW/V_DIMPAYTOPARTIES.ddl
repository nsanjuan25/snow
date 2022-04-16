create or replace view V_DIMPAYTOPARTIES(
	PAYTOPARTYCODE,
	PAYTOPARTYTYPECODE,
	CORPORATIONID,
	GLOBALPAYTOPARTYNAME,
	LOCALPAYTOPARTYNAME,
	LOCALPAYTOPARTYNAME2,
	LOCALPAYTOPARTYNAME3,
	LOCALPAYTOPARTYNAME4,
	ADDRESS1,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	POSTALCODE,
	SRCLASTMODIFIEDDATE,
	PAYMENTTERMS,
	ORGANIZATIONCODE,
	ORGANIZATIONTYPECODE,
	ACCOUNTINGPAYTOPARTYCODE,
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

This view is used to insert data into SAP.DimPaytoParty
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-02      Mansi Choudhary       Initial Revision
  */

	SELECT
	      PayToPartyCode 
		, PayToPartyTypeCode
		, CorporationID
	    , GlobalPayToPartyName
	    , LocalPayToPartyName
	    , LocalPayToPartyName2	
	    , LocalPayToPartyName3
	    , LocalPayToPartyName4
	    , Address1
	    , City	
	    , StateProvince	
	    , Country
	    , PostalCode
	    , SrcLastModifiedDate	
	    , PaymentTerms
	    , OrganizationCode
	    , OrganizationTypeCode
	    , AccountingPayToPartyCode
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
        conformed.V_ecc_ha_DIMPAYTOPARTIES;