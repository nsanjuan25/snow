create or replace view V_ECC_HA_DIMCUSTOMERS(
	CUSTOMERCODE,
	CORPORATIONID,
	CUSTOMERTYPECODE,
	DATASOURCEKEY,
	GLOBALCUSTOMERNAME,
	LOCALCUSTOMERNAME,
	LOCALCUSTOMERNAME2,
	LOCALCUSTOMERNAME3,
	LOCALCUSTOMERNAME4,
	ADDRESS1,
	CITY,
	STATEPROVINCE,
	COUNTRY,
	POSTALCODE,
	PAYMENTTERMS,
	ORGANIZATIONCODE,
	ORGANIZATIONTYPECODE,
	ACCOUNTINGCUSTOMERCODE,
	DELETEFLAG,
	MINORITYINDICATOR,
	MINORITYTEXT,
	CERTIFICATIONDATE,
	VENDORMASTERPAYMENTTERMS,
	VENDORCLASSIFICATION,
	SRCLASTMODIFIEDDATE,
	DUNSNUMBER,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into V_ECC_HA_DIMCUSTOMERS
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-03      SRIDHAR                 Initial Revision
  */
select CUSTOMERCODE,
CORPORATIONID,
CUSTOMERTYPECODE,
DATASOURCEKEY,
GLOBALCUSTOMERNAME,
LOCALCUSTOMERNAME,
LOCALCUSTOMERNAME2,
LOCALCUSTOMERNAME3,
LOCALCUSTOMERNAME4,
ADDRESS1,
CITY,
STATEPROVINCE,
COUNTRY,
POSTALCODE,
PAYMENTTERMS,
ORGANIZATIONCODE,
ORGANIZATIONTYPECODE,
ACCOUNTINGCUSTOMERCODE,
DELETEFLAG,
MINORITYINDICATOR,
MINORITYTEXT,
CERTIFICATIONDATE,
VENDORMASTERPAYMENTTERMS,
VENDORCLASSIFICATION,
SRCLASTMODIFIEDDATE,
DUNSNUMBER,
hash( 
CORPORATIONID,
CUSTOMERTYPECODE,
DATASOURCEKEY,
GLOBALCUSTOMERNAME,
LOCALCUSTOMERNAME,
LOCALCUSTOMERNAME2,
LOCALCUSTOMERNAME3,
LOCALCUSTOMERNAME4,
ADDRESS1,
CITY,
STATEPROVINCE,
COUNTRY,
POSTALCODE,
PAYMENTTERMS,
ORGANIZATIONCODE,
ORGANIZATIONTYPECODE,
ACCOUNTINGCUSTOMERCODE,
DELETEFLAG,
MINORITYINDICATOR,
MINORITYTEXT,
CERTIFICATIONDATE,
VENDORMASTERPAYMENTTERMS,
VENDORCLASSIFICATION,
SRCLASTMODIFIEDDATE,
DUNSNUMBER) hash_value

 from 
(SELECT
	      RTRIM(LTRIM(RTRIM(UPPER( C.CorporationDSCode )))) AS CustomerCode 
	    , C.CorporationID AS CorporationID 
	    ,  LTRIM( UPPER( ds.CorporationDSTypeCode )) AS CustomerTypeCode 
	    , nvl(dd.DataSourceKey,0) DataSourceKey
	    , nvl(GC.CorporationName,'')   GlobalCustomerName
	    , nvl(C.CorporationDSName,'')   LocalCustomerName
	    , nvl(C.CorporationDSName2,'')  LocalCustomerName2	
	    , nvl(C.CorporationDSName3,'')	LocalCustomerName3
	    , nvl(C.CorporationDSName4,'')	LocalCustomerName4
	    , nvl(C.Address,'')Address1
	    , nvl(C.City,'') city	
	    , nvl(C.StateProvince,'') 	StateProvince
	    , nvl(C.Country,'')	Country
	    , nvl(C.PostalCode,'')	PostalCode
	    ,  '' PaymentTerms
	    ,  '' OrganizationCode
	    ,  '' OrganizationTypeCode
	    ,  '' AccountingCustomerCode
	    , CASE UPPER(C.DeleteFlag) WHEN 'TRUE' THEN 1 WHEN 'FALSE' THEN 0 ELSE 0 END DeleteFlag 
	    ,  '' MinorityIndicator
	    ,  '' MinorityText
	    ,  '' CertificationDate
	    ,  '' VendorMasterPaymentTerms
	    ,  '' VendorClassification	
	    , C.SNFLK_UPDATEDON  SrcLastModifiedDate
		, nvl(C.DUNSNumber, '') AS DUNSNumber
	    
    FROM 
        CONFORMED.SCMDB_CORPORATIONDS C 
        INNER JOIN CONFORMED.SCMDB_CORPORATION GC ON C.CorporationID = GC.CorporationID
        INNER JOIN CONFORMED.SCMDB_CORPORATIONDSType ds  ON C.CorporationDSTypeID = ds.CorporationDSTypeID
            AND C.DataSourceId = DS.DataSourceId
        INNER JOIN CONFORMED.SCMDB_CORPORATIONDSTypeStd std ON ds.CorporationDSTypeStdID = std.CorporationDSTypeStdID
	   LEFT OUTER JOIN PUBLIC.DimDataSources dd 
			ON DD.JDB_DataSourceId = C.DataSourceID
    WHERE 
            std.CorporationDSTypeStdCode = 'Customer');