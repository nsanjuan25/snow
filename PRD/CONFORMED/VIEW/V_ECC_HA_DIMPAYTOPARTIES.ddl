create or replace view V_ECC_HA_DIMPAYTOPARTIES(
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
(

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
	      C.CorporationDSCode as PayToPartyCode 
		, ds.CorporationDSTypeCode	as PayToPartyTypeCode
		, C.CorporationID
	    , GC.CorporationName as GlobalPayToPartyName
	    , IFNULL(C.CorporationDSName,'') as LocalPayToPartyName
	    , IFNULL(C.CorporationDSName2,'') as LocalPayToPartyName2	
	    , IFNULL(C.CorporationDSName3,'')	as LocalPayToPartyName3
	    , IFNULL(C.CorporationDSName4,'')	as LocalPayToPartyName4
	    , IFNULL(C.Address,'') as Address1
	    , IFNULL(C.City,'') as City	
	    , IFNULL(C.StateProvince,'') as StateProvince	
	    , IFNULL(C.Country,'') as Country
	    , IFNULL(C.PostalCode,'') as  PostalCode
	    , C.SNFLK_UPDATEDON as SrcLastModifiedDate	
	    , '' PaymentTerms
	    , '' OrganizationCode
	    , '' OrganizationTypeCode
	    , '' AccountingPayToPartyCode
	    , CASE UPPER(C.DeleteFlag) WHEN 'TRUE' THEN 1 WHEN 'FALSE' THEN 0 ELSE 0 END DeleteFlag 
	    , '' MinorityIndicator
	    , '' MinorityText
	    , '' CertificationDate
	    , '' VendorMasterPaymentTerms
	    , '' VendorClassification
	    , DD.DataSourceKey
		, IFNULL(C.DUNSNumber, '') AS DUNSNumber
	    , HASH(C.CorporationDSName,GC.CorporationName,C.CorporationDSName2,C.CorporationDSName3,C.CorporationDSName4,C.Address,C.City,C.StateProvince,C.Country,C.PostalCode,C.DUNSNumber,C.CorporationID,ds.CorporationDSTypeCode)  AS HASH_VALUE
    FROM 
        CONFORMED.SCMDB_CorporationDs C 
        INNER JOIN CONFORMED.SCMDB_Corporation GC ON C.CorporationID = GC.CorporationID
        INNER JOIN CONFORMED.SCMDB_CorporationDSType ds ON C.CorporationDSTypeID = ds.CorporationDSTypeID
            AND C.DatasourceID = DS.DataSourceId
        INNER JOIN CONFORMED.SCMDB_CorporationDSTypeStd std ON ds.CorporationDSTypeStdID = std.CorporationDSTypeStdID
		INNER JOIN PUBLIC.DimDataSources dd ON DD.JDB_DataSourceId = C.DataSourceID
    WHERE 
        std.CorporationDSTypeStdCode = 'Pay-To-Party'
);