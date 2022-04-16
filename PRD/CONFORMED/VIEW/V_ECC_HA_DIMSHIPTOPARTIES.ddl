create or replace view V_ECC_HA_DIMSHIPTOPARTIES(
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
	      C.CorporationDSCode      as ShipToPartyCode 
		, ds.CorporationDSTypeCode as ShipToPartyTypeCode	
		, C.CorporationID
	    , GC.CorporationName       as GlobalShipToPartyName
	    , IFNULL(C.CorporationDSName,'')    as LocalShipToPartyName
	    , IFNULL(C.CorporationDSName2,'')   as LocalShipToPartyName2	
	    , IFNULL(C.CorporationDSName3,'')	as LocalShipToPartyName3
	    , IFNULL(C.CorporationDSName4,'')	as LocalShipToPartyName4
	    , IFNULL(C.Address,'') as Address1
	    , IFNULL(C.City,'')    as City	
	    , IFNULL(C.StateProvince,'') as StateProvince	
	    , IFNULL(C.Country,'') as Country
	    , IFNULL(C.PostalCode,'') as PostalCode
	    , C.SNFLK_UPDATEDON as SrcLastModifiedDate	
	    , '' as PaymentTerms
	    , '' as OrganizationCode
	    , '' as OrganizationTypeCode
	    , '' as AccountingShipToPartyCode
	    , CASE UPPER(C.DeleteFlag) WHEN 'TRUE' THEN 1 WHEN 'FALSE' THEN 0 ELSE 0 END as DeleteFlag 
	    , '' as MinorityIndicator
	    , '' as MinorityText
	    , '' as CertificationDate
	    , '' as VendorMasterPaymentTerms
	    , '' as VendorClassification
	    , dd.DataSourceKey as DataSourceKey
		, IFNULL(C.DUNSNumber, '') as DUNSNumber
	    , HASH(C.CorporationDSName,GC.CorporationName,C.CorporationDSName2,C.CorporationDSName3,C.CorporationDSName4,C.Address,C.City,C.StateProvince,C.Country,C.PostalCode,C.CorporationID,C.DUNSNumber,ds.CorporationDSTypeCode) As HASH_VALUE
    FROM 
        CONFORMED.SCMDB_CorporationDs C         
        INNER JOIN CONFORMED.SCMDB_Corporation GC ON C.CorporationID = GC.CorporationID
        INNER JOIN CONFORMED.SCMDB_CorporationDSType ds ON C.CorporationDSTypeID = ds.CorporationDSTypeID
            AND C.DatasourceID = DS.DataSourceId
        INNER JOIN CONFORMED.SCMDB_CorporationDSTypeStd std ON ds.CorporationDSTypeStdID = std.CorporationDSTypeStdID
		INNER JOIN PUBLIC.DimDataSources dd ON DD.JDB_DataSourceId = C.DataSourceID        
    WHERE 
        std.CorporationDSTypeStdCode = 'Ship-To-Party';