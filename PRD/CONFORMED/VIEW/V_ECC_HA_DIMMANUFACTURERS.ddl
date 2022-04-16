create or replace view V_ECC_HA_DIMMANUFACTURERS(
	DATASOURCEKEY,
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
          DD.DataSourceKey
	    , TRIM(UPPER(C.CorporationDSCode))          AS ManufacturerCode
		, C.CorporationID							AS CorporationID
        , TRIM(UPPER(IFNULL(ds.CorporationDSTypeCode,'')))    AS ManufacturerTypeCode
	    , TRIM(GC.CorporationName)                 AS GlobalManufacturerName
	    , TRIM(IFNULL(C.CorporationDSName,''))     AS LocalManufacturerName
	    , TRIM(IFNULL(C.CorporationDSName2,''))    AS LocalManufacturerName2
	    , TRIM(IFNULL(C.CorporationDSName3,''))	   AS LocalManufacturerName3
	    , TRIM(IFNULL(C.CorporationDSName4,''))	   AS LocalManufacturerName4
	    , TRIM(IFNULL(C.Address,''))               AS Address1

	    , TRIM(IFNULL(C.City,''))                  AS City
	    , TRIM(IFNULL(C.StateProvince,''))         AS StateProvince
   	    , TRIM(IFNULL(C.Country,''))               AS Country
	    , TRIM(IFNULL(C.PostalCode,''))            AS PostalCode     
        , ''                                       AS PaymentTerms
	    , ''                                       AS OrganizationCode
	    , ''                                       AS OrganizationTypeCode
	    , ''                                       AS AccountingManufacturerCode
	    , IFNULL(C.DeleteFlag,'FALSE')              AS DeleteFlag                            
	    , ''                                       AS MinorityIndicator
	    , ''                                       AS MinorityText
	    , ''                                       AS CertificationDate
	    , ''                                       AS VendorMasterPaymentTerms
	    , ''                                       AS VendorClassification
		, IFNULL(C.DUNSNumber, '')                 AS DUNSNumber
    FROM 
        conformed.scmdb_CorporationDs C 
        INNER JOIN conformed.scmdb_Corporation GC ON C.CorporationID = GC.CorporationID
        INNER JOIN conformed.scmdb_CorporationDSType ds ON C.CorporationDSTypeID = ds.CorporationDSTypeID
            AND C.DatasourceID = DS.DataSourceId
        INNER JOIN conformed.scmdb_CorporationDSTypeStd std ON ds.CorporationDSTypeStdID = std.CorporationDSTypeStdID		
        INNER JOIN Public.DimDataSources dd ON DD.JDB_DataSourceId = C.DataSourceID
    WHERE 
        std.CorporationDSTypeStdCode = 'Manufacturer';