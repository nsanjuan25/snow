create or replace view V_DIMSUPPLIERS(
	SUPPLIERCODE,
	CORPORATIONID,
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
	DUNSNUMBER,
	HASH_VALUE,
	RN
) as
/*-------------------------------------------------------------------------------------------

This view  used to populate Non Consigned Historical Spend
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-**-**								Initial Revision
2021-10-25		Sridhar Koormadasu		Changed join in dimdatasources from inner to left join
2021-10-28      Jagan Policherla        Added JPS and PLA
*/
SELECT 
    *
FROM  
  (
  SELECT 
      * 
      , ROW_NUMBER() OVER (PARTITION BY SupplierCode , SupplierTypeCode,DataSourceKey ORDER BY DeleteFlag,SupplierCode ) AS RN
  FROM
      (
          SELECT 
              S.SupplierCode
            , s.CorporationID
            , S.SupplierTypeCode
            , s.SupplierType 
            , s.SupplierContract 
            , S.VIAFlag
            , S.DataSourceKey
            , S.GlobalSupplierName
            , S.LocalSupplierName
            , S.LocalSupplierName2
            , S.LocalSupplierName3
            , S.LocalSupplierName4
            , S.Address1
            , S.City
            , S.StateProvince
            , S.Country
            , S.PostalCode
            , S.PaymentTerms
            , S.OrganizationCode
            , S.OrganizationTypeCode
            , S.AccountingSupplierCode
            , S.DeleteFlag
            , S.MinorityIndicator
            , S.MinorityText
            , S.CertificationDate
            , S.VendorMasterPaymentTerms
            , S.VendorClassification
            , S.SrcLastModifiedDate
            , IFNULL(S.DUNSNumber, '') AS DUNSNumber
            , S.HASH_VALUE
          FROM 
              (
                SELECT
                    SupplierCode
                  , CorporationID
                  , SupplierTypeCode
                  , VIAFlag
                  , SupplierType 
                  , SupplierContract 
                  , DataSourceKey
                  , GlobalSupplierName
                  , LocalSupplierName
                  , LocalSupplierName2
                  , LocalSupplierName3
                  , LocalSupplierName4
                  , Address1
                  , City
                  , StateProvince
                  , Country
                  , PostalCode
                  , PaymentTerms
                  , OrganizationCode
                  , OrganizationTypeCode
                  , AccountingSupplierCode
                  , DeleteFlag
                  , MinorityIndicator
                  , MinorityText
                  , CertificationDate
                  , VendorMasterPaymentTerms
                  , VendorClassification
                  , SrcLastModifiedDate
                  , A1.DUNSNumber

                  , HASH(SupplierCode,CorporationID,SupplierTypeCode ,VIAFlag,SupplierType ,SupplierContract ,DataSourceKey,GlobalSupplierName,LocalSupplierName,LocalSupplierName2,LocalSupplierName3,LocalSupplierName4,Address1,City,StateProvince ,Country,PostalCode,PaymentTerms,OrganizationCode,OrganizationTypeCode,AccountingSupplierCode,DeleteFlag,MinorityIndicator,MinorityText,CertificationDate,VendorMasterPaymentTerms,VendorClassification,A1.DUNSNumber) AS HASH_VALUE
              FROM 
                  (
                      SELECT 
                            ROW_NUMBER() OVER (PARTITION BY SupplierCode , SupplierTypeCode,DataSourceKey ORDER BY DeleteFlag,SupplierCode ) AS ROW_ID
                          , SupplierCode	
                          , CorporationID
                          , SupplierTypeCode
                          , CASE WHEN VIA_FLAG	= 11 THEN 0 ELSE 1 END AS VIAFlag
                          , SupplierType 
                          , SupplierContract 
                          , DataSourceKey	
                          , GlobalSupplierName	
                          , LocalSupplierName	
                          , LocalSupplierName2	
                          , LocalSupplierName3	
                          , LocalSupplierName4	
                          , Address1	
                          , City	
                          , StateProvince	
                          , Country	
                          , PostalCode	
                          , PaymentTerms	
                          , OrganizationCode	
                          , OrganizationTypeCode	
                          , AccountingSupplierCode	
                          , DeleteFlag	
                          , MinorityIndicator	
                          , MinorityText	
                          , CertificationDate	
                          , VendorMasterPaymentTerms	
                          , VendorClassification	
                          , SrcLastModifiedDate	
                          , A.DUNSNumber
                      FROM
                          (
                              SELECT  
                                    SupplierCode
                                  , B.CorporationID
                                  , SupplierTypeCode
                                  , MAX(VIA) AS VIA
                                  , Max(CASE WHEN NONVIA = 'OEM' THEN 'AA' 
                                          WHEN NONVIA = 'GCM Supplier' THEN 'AA' 
                                          ELSE NONVIA END
                                      ) AS NONVIA
                                  , Sum(VIA_FLAG) AS VIA_FLAG
                                  , IFNULL ( MAX(B.SupplierType),'UNDF' )     AS SupplierType
                                  , IFNULL ( MAX(B.SupplierContract),'UNDF' ) AS SupplierContract
                                  , DataSourceKey
                                  , GlobalSupplierName
                                  , LocalSupplierName
                                  , LocalSupplierName2
                                  , LocalSupplierName3
                                  , LocalSupplierName4
                                  , Address1
                                  , City
                                  , StateProvince
                                  , Country
                                  , PostalCode
                                  , PaymentTerms
                                  , OrganizationCode
                                  , OrganizationTypeCode
                                  , AccountingSupplierCode
                                  , Max(DeleteFlag) as DeleteFlag
                                  , MinorityIndicator
                                  , MinorityText
                                  , CertificationDate
                                  , VendorMasterPaymentTerms
                                  , VendorClassification
                                  , Max(SrcLastModifiedDate) AS SrcLastModifiedDate 
                                  , B.DUNSNumber
                              FROM
                                  (
                                      SELECT 
                                            TRIM(C.CorporationDSCode) SupplierCode 
                                          , RTRIM(C.CorporationID) CorporationID 
                                          , TRIM(DS.CorporationDSTypeCode) AS SupplierTypeCode 
                                          , (CASE WHEN IFNULL(CV.CorporationMaintenanceValueName,'') = 'VIA' THEN NULL ELSE CV.CorporationMaintenanceValueName END )  AS NONVIA
                                          , (CASE WHEN IFNULL(CV.CorporationMaintenanceValueName,'') = 'VIA' THEN CV.CorporationMaintenanceValueName ELSE NULL END ) AS VIA
                                          , (CASE WHEN IFNULL(CV.CorporationMaintenanceValueName,'') = 'VIA' THEN 1 Else 11 END ) AS VIA_FLAG

                                          , CASE WHEN CV.CorporationMaintenanceID = 1  THEN CV.CorporationMaintenanceValueName END AS SupplierType
                                          , CASE WHEN CV.CorporationMaintenanceID = 8  THEN CV.CorporationMaintenanceValueName END AS SupplierContract

                                          , DD.DataSourceKey
                                          , GC.CorporationName GlobalSupplierName
                                          , IFNULL(C.CorporationDSName,'') LocalSupplierName
                                          , IFNULL(C.CorporationDSName2,'') LocalSupplierName2	
                                          , IFNULL(C.CorporationDSName3,'')	LocalSupplierName3
                                          , IFNULL(C.CorporationDSName4,'')	LocalSupplierName4
                                          , IFNULL(C.Address,'') Address1
                                          , IFNULL(C.City,'') City	
                                          , IFNULL(C.StateProvince,'') StateProvince	
                                          , IFNULL(C.Country,'') Country
                                          , IFNULL(C.PostalCode,'') PostalCode
                                          , '' PaymentTerms
                                          , '' OrganizationCode
                                          , '' OrganizationTypeCode
                                          , '' AccountingSupplierCode
                                          , CASE UPPER(C.DeleteFlag) WHEN 'TRUE' THEN 1 WHEN 'FALSE' THEN 0 ELSE 0 END DeleteFlag 
                                          , '' MinorityIndicator
                                          , '' MinorityText
                                          , '' CertificationDate
                                          , '' VendorMasterPaymentTerms
                                          , IFNULL(C.VendorClassification,'') AS VendorClassification
                                          , C.snflk_UPDATEdON as  SrcLastModifiedDate
                                          , C.DUNSNumber
                                      FROM 
                                          CONFORMED.ECC_HA_LFA1 LF
                                          INNER JOIN CONFORMED.SCMDB_CorporationDs C 
                                              ON trim(LF.lifnr) = trim(C.CorporationDSCode)
                                              AND upper(lf.ktokk) <> 'ZMFG'
                                          INNER JOIN CONFORMED.SCMDB_Corporation GC
                                              ON C.CorporationID = GC.CorporationID
                                          INNER JOIN CONFORMED.SCMDB_CorporationDSType DS 
                                              ON C.CorporationDSTypeID = DS.CorporationDSTypeID
                                              AND trim(LF.ktokk) = trim(DS.CorporationDSTypeCode)
                                              AND C.DataSourceID = DS.DataSourceID
                                          INNER JOIN CONFORMED.SCMDB_CorporationDSTypeStd std
                                              ON ds.CorporationDSTypeStdID = std.CorporationDSTypeStdID
                                          LEFT OUTER JOIN CONFORMED.SCMDB_CorporationInfo CI
                                              ON C.CorporationID = CI.CorporationID
                                          LEFT OUTER JOIN (Select * from CONFORMED.SCMDB_CorporationMaintenanceValue
                                                        WHERE CorporationMaintenanceID IN (1,8)) CV
                                              ON CI.CorporationMaintenanceID = CV.CorporationMaintenanceID
                                              AND CI.CorporationMaintenanceValueID = CV.CorporationMaintenanceValueID
                                          LEFT OUTER JOIN SAP.DimSupplierTypes DST 
                                              on (DST.SupplierType =CV.CorporationMaintenanceValueName )
                                          LEFT OUTER JOIN PUBLIC.DimDataSources dd 
                                              ON DD.JDB_DataSourceId = C.DataSourceID
                                      WHERE 
                                          C.DataSourceId = 6 



                                      UNION ALL


                                      SELECT 
                                            TRIM(C.CorporationDSCode) SupplierCode 
                                          , RTRIM(C.CorporationID) CorporationID 
                                          , TRIM(DS.CorporationDSTypeCode) AS SupplierTypeCode 
                                          , (CASE WHEN IFNULL(CV.CorporationMaintenanceValueName,'') = 'VIA' THEN NULL ELSE CV.CorporationMaintenanceValueName END )  AS NONVIA
                                          , (CASE WHEN IFNULL(CV.CorporationMaintenanceValueName,'') = 'VIA' THEN CV.CorporationMaintenanceValueName ELSE NULL END ) AS VIA
                                          , (CASE WHEN IFNULL(CV.CorporationMaintenanceValueName,'') = 'VIA' THEN 1 Else 11 END ) AS VIA_FLAG

                                          , CASE WHEN CV.CorporationMaintenanceID = 1  THEN CV.CorporationMaintenanceValueName END AS SupplierType
                                          , CASE WHEN CV.CorporationMaintenanceID = 8  THEN CV.CorporationMaintenanceValueName END AS SupplierContract

                                          , dd.DataSourceKey
                                          , GC.CorporationName GlobalSupplierName
                                          , IFNULL(C.CorporationDSName,'') LocalSupplierName
                                          , IFNULL(C.CorporationDSName2,'') LocalSupplierName2	
                                          , IFNULL(C.CorporationDSName3,'')	LocalSupplierName3
                                          , IFNULL(C.CorporationDSName4,'')	LocalSupplierName4
                                          , IFNULL(C.Address,'') Address1
                                          , IFNULL(C.City,'') City	
                                          , IFNULL(C.StateProvince,'') StateProvince	
                                          , IFNULL(C.Country,'') Country
                                          , IFNULL(C.PostalCode,'') PostalCode
                                          , '' PaymentTerms
                                          , '' OrganizationCode
                                          , '' OrganizationTypeCode
                                          , '' AccountingSupplierCode
                                          , CASE UPPER(C.DeleteFlag) WHEN 'TRUE' THEN 1 WHEN 'FALSE' THEN 0 ELSE 0 END DeleteFlag 
                                          , '' MinorityIndicator
                                          , '' MinorityText
                                          , '' CertificationDate
                                          , '' VendorMasterPaymentTerms
                                          , IFNULL(C.VendorClassification,'') AS VendorClassificatio
                                          , C.snflk_UPDATEdON SrcLastModifiedDate
                                          , C.DUNSNumber
                                      FROM 
                                          CONFORMED.SCMDB_CorporationDs C 
                                          INNER JOIN CONFORMED.SCMDB_Corporation GC
                                              ON C.CorporationID = GC.CorporationID
                                          INNER JOIN CONFORMED.SCMDB_CorporationDSType DS 
                                              ON C.CorporationDSTypeID = DS.CorporationDSTypeID
                                              AND C.DataSourceID = DS.DataSourceID
                                          INNER JOIN CONFORMED.SCMDB_CorporationDSTypeStd std
                                              ON ds.CorporationDSTypeStdID = std.CorporationDSTypeStdID
                                          LEFT OUTER JOIN PUBLIC.DimDataSources dd 
                                              ON DD.JDB_DataSourceId = C.DataSourceID                                  
                                          LEFT OUTER JOIN CONFORMED.SCMDB_CorporationInfo CI
                                              ON C.CorporationID = CI.CorporationID

                                           LEFT OUTER JOIN CONFORMED.SCMDB_CorporationMaintenanceValue CV                                    
                                               ON CI.CorporationMaintenanceID = CV.CorporationMaintenanceID
                                                AND CI.CorporationMaintenanceValueID = CV.CorporationMaintenanceValueID
                                                AND CV.CorporationMaintenanceID IN ( 1, 8)


                                          LEFT OUTER JOIN SAP.DimSupplierTypes DST 
                                              on (DST.SupplierType =CV.CorporationMaintenanceValueName )
                                      WHERE
                                          
                                             (
                                              C.DataSourceId <> 6 
                                              AND std.CorporationDSTypeStdCode = 'Supplier'
                                              )
                                              OR
                                             (
											(
                                                  C.DataSourceId = 6 
                                                  AND std.CorporationDSTypeStdCode = 'Supplier'
                                              )
                                          
                                          AND NOT EXISTS ( SELECT NULL FROM CONFORMED.ECC_HA_LFA1 LF WHERE trim(lifnr) = trim(C.CorporationDSCode)  AND upper(ktokk) <> 'ZMFG' AND trim(ktokk) = trim(DS.CorporationDSTypeCode) )
										)
                                  ) B
                      GROUP BY  
                            SupplierCode
                          , CorporationID
                          , SupplierTypeCode
                          , DataSourceKey
                          , GlobalSupplierName
                          , LocalSupplierName
                          , LocalSupplierName2
                          , LocalSupplierName3
                          , LocalSupplierName4
                          , Address1
                          , City
                          , StateProvince
                          , Country
                          , PostalCode
                          , PaymentTerms
                          , OrganizationCode
                          , OrganizationTypeCode
                          , AccountingSupplierCode
                          , MinorityIndicator
                          , MinorityText
                          , CertificationDate
                          , VendorMasterPaymentTerms
                          , VendorClassification 
                          , B.DUNSNumber

                  ) A 
              )A1
              WHERE 
                  A1.ROW_ID = 1
          ) S
            LEFT OUTER JOIN SAP.DimSupplierTypes T ON T.SupplierType = S.SupplierType

          UNION ALL 

          SELECT 
              TRIM(UPPER(ESV.lifnr))      AS SupplierCode
            , 0							AS CorporationID 
            , TRIM(UPPER(ESV.ktokk))      AS SupplierTypeCode
            , 'UNDF'                      AS SupplierType
            , 'UNDF'                      AS SupplierContract
            , 0                           AS VIAFlag
            , 1                           AS DataSourceKey   
            , 'UNDF'                      AS GlobalSupplierName
            , RTRIM(ESV.name1)            AS LocalSupplierName
            , RTRIM(ESV.name2)            AS LocalSupplierName2
            , RTRIM(ESV.name3)            AS LocalSupplierName3
            , RTRIM(ESV.name4)            AS LocalSupplierName4
            , RTRIM(ESV.stras)            AS Address1
            , RTRIM(ESV.ort01)            AS City
            , RTRIM(ESV.regio)            AS StateProvince
            , RTRIM(ESV.land1)            AS Country
            , RTRIM(ESV.pstlz)            AS PostalCode
            , ''                          AS PaymentTerms
            , ''                          AS OrganizationCode
            , ''                          AS OrganizationTypeCode
            , ''                          AS AccountingSupplierCode
            , CASE WHEN ESV.loevm = 'X' THEN 1 ELSE 0 END AS DeleteFlag
            , ''                          AS MinorityIndicator
            , ''                          AS MinorityText
            , ''                          AS CertificationDate
            , ''                          AS VendorMasterPaymentTerms
            , ''                          AS VendorClassificatio
            , ESV.snflk_UpdateDOn         AS SrLastModifiedDate
            , ''                          AS DUNSNumber
            , HASH( ESV.lifnr,ESV.ktokk,ESV.name1,ESV.name2,ESV.name3,ESV.name4,ESV.stras,ESV.ort01,ESV.regio,ESV.land1,ESV.pstlz,ESV.loevm) As HASH_VALUE
          FROM 
              CONFORMED.ECC_HA_LFA1 AS ESV
          WHERE 
              NOT EXISTS (SELECT NULL FROM CONFORMED.SCMDB_CorporationDs WHERE trim(CorporationDSCode) = trim(lifnr) ) 		
              AND upper(ESV.ktokk) not in( 'ZMFG' )

          UNION ALL 

          SELECT 
              TRIM(UPPER(ESV.lifnr))      AS SupplierCode
            , 0							AS CorporationID 
            , TRIM(UPPER(ESV.ktokk))      AS SupplierTypeCode
            , 'UNDF'                      AS SupplierType
            , 'UNDF'                      AS SupplierContract
            , 0                           AS VIAFlag
            , 2                           AS DataSourceKey   
            , 'UNDF'                      AS GlobalSupplierName
            , RTRIM(ESV.name1)            AS LocalSupplierName
            , RTRIM(ESV.name2)            AS LocalSupplierName2
            , RTRIM(ESV.name3)            AS LocalSupplierName3
            , RTRIM(ESV.name4)            AS LocalSupplierName4
            , RTRIM(ESV.stras)            AS Address1
            , RTRIM(ESV.ort01)            AS City
            , RTRIM(ESV.regio)            AS StateProvince
            , RTRIM(ESV.land1)            AS Country
            , RTRIM(ESV.pstlz)            AS PostalCode
            , ''                          AS PaymentTerms
            , ''                          AS OrganizationCode
            , ''                          AS OrganizationTypeCode
            , ''                          AS AccountingSupplierCode
            , CASE WHEN ESV.loevm = 'X' THEN 1 ELSE 0 END AS DeleteFlag
            , ''                          AS MinorityIndicator
            , ''                          AS MinorityText
            , ''                          AS CertificationDate
            , ''                          AS VendorMasterPaymentTerms
            , ''                          AS VendorClassificatio
            , ESV.snflk_UpdateDOn              AS SrLastModifiedDate
            , ''                          AS DUNSNumber
            , HASH( ESV.lifnr,ESV.ktokk,ESV.name1,ESV.name2,ESV.name3,ESV.name4,ESV.stras,ESV.ort01,ESV.regio,ESV.land1,ESV.pstlz,ESV.loevm) As HASH_VALUE
          FROM 
              CONFORMED.HCC_HA_LFA1 AS ESV
			
          UNION ALL 

          SELECT TRIM(UPPER(ESV.lifnr))      AS SupplierCode
               , 0  					     AS CorporationID 
               , TRIM(UPPER(ESV.ktokk))      AS SupplierTypeCode
               , 'UNDF'                      AS SupplierType
               , 'UNDF'                      AS SupplierContract
               , 0                           AS VIAFlag
               , 5                           AS DataSourceKey   
               , 'UNDF'                      AS GlobalSupplierName
               , RTRIM(ESV.name1)            AS LocalSupplierName
               , RTRIM(ESV.name2)            AS LocalSupplierName2
               , RTRIM(ESV.name3)            AS LocalSupplierName3
               , RTRIM(ESV.name4)            AS LocalSupplierName4
               , RTRIM(ESV.stras)            AS Address1
               , RTRIM(ESV.ort01)            AS City
               , RTRIM(ESV.regio)            AS StateProvince
               , RTRIM(ESV.land1)            AS Country
               , RTRIM(ESV.pstlz)            AS PostalCode
               , ''                          AS PaymentTerms
               , ''                          AS OrganizationCode
               , ''                          AS OrganizationTypeCode
               , ''                          AS AccountingSupplierCode
               , CASE WHEN ESV.loevm = 'X' THEN 1 ELSE 0 END AS DeleteFlag
               , ''                          AS MinorityIndicator
               , ''                          AS MinorityText
               , ''                          AS CertificationDate
               , ''                          AS VendorMasterPaymentTerms
               , ''                          AS VendorClassificatio
               , ESV.snflk_UpdateDOn         AS SrLastModifiedDate
               , ''                          AS DUNSNumber
               , HASH( ESV.lifnr,ESV.ktokk,ESV.name1,ESV.name2,ESV.name3,ESV.name4,ESV.stras,ESV.ort01,ESV.regio,ESV.land1,ESV.pstlz,ESV.loevm) As HASH_VALUE
          FROM   CONFORMED.JPS_HA_LFA1 AS ESV
          WHERE 
              ESV.ktokk not in( 'ZMFG' )
			  
          UNION ALL 

          SELECT TRIM(UPPER(ESV.lifnr))      AS SupplierCode
               , 0  					     AS CorporationID 
               , TRIM(UPPER(ESV.ktokk))      AS SupplierTypeCode
               , 'UNDF'                      AS SupplierType
               , 'UNDF'                      AS SupplierContract
               , 0                           AS VIAFlag
               , 4                           AS DataSourceKey   
               , 'UNDF'                      AS GlobalSupplierName
               , RTRIM(ESV.name1)            AS LocalSupplierName
               , RTRIM(ESV.name2)            AS LocalSupplierName2
               , RTRIM(ESV.name3)            AS LocalSupplierName3
               , RTRIM(ESV.name4)            AS LocalSupplierName4
               , RTRIM(ESV.stras)            AS Address1
               , RTRIM(ESV.ort01)            AS City
               , RTRIM(ESV.regio)            AS StateProvince
               , RTRIM(ESV.land1)            AS Country
               , RTRIM(ESV.pstlz)            AS PostalCode
               , ''                          AS PaymentTerms
               , ''                          AS OrganizationCode
               , ''                          AS OrganizationTypeCode
               , ''                          AS AccountingSupplierCode
               , CASE WHEN ESV.loevm = 'X' THEN 1 ELSE 0 END AS DeleteFlag
               , ''                          AS MinorityIndicator
               , ''                          AS MinorityText
               , ''                          AS CertificationDate
               , ''                          AS VendorMasterPaymentTerms
               , ''                          AS VendorClassificatio
               , ESV.snflk_UpdateDOn         AS SrLastModifiedDate
               , ''                          AS DUNSNumber
               , HASH( ESV.lifnr,ESV.ktokk,ESV.name1,ESV.name2,ESV.name3,ESV.name4,ESV.stras,ESV.ort01,ESV.regio,ESV.land1,ESV.pstlz,ESV.loevm) As HASH_VALUE
          FROM   CONFORMED.PLA_HA_LFA1 AS ESV
          WHERE 
              ESV.ktokk not in( 'ZMFG' )
			  
      ) Al
    ) a2
  WHERE 
        A2.RN = 1;