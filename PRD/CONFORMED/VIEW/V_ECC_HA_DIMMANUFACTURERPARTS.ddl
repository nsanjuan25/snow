create or replace view V_ECC_HA_DIMMANUFACTURERPARTS(
	SRCMFRPARTID,
	TEMPCORPORATIONID,
	MANUFACTURERPARTCODE,
	MANUFACTURERPARTDESCRIPTION,
	COMMODITY,
	COMMODITYCATEGORY,
	INTERNALSTATUS,
	CLASSIFICATIONSTATUSCODE,
	DELETEFLAG,
	LOCALMANUFACTURERNAME,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.DimManufacturerParts table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-24      Noel San Juan          Initial Revision
*/

  SELECT
      MAX(M.MfrPartID)          							AS srcMfrPartID,
      M.CorporationID										AS TempCorporationID,
      IFNULL(RTRIM( M.MfrPartCode ),'')						AS ManufacturerPartCode,
      IFNULL(M.MfrPartDescription,'')						AS ManufacturerPartDescription,
      IFNULL(UPPER( C.ClassName ),'UNCLASSIFIED')			AS Commodity,
      IFNULL(UPPER( CC.Category ),'UNDEFINED')				AS CommodityCategory,
      CASE 
          WHEN M.InternalStatusID = 1 THEN 'VERIFIED' 
          WHEN M.InternalStatusID = 2 THEN 'OBSOLETE'
          ELSE ''
      END AS InternalStatus,    
      IFNULL( UPPER( EJCS.classificationstatuscode ),'')	AS ClassificationStatusCode,
      IFNULL(M.DeleteFlag,'FALSE')							AS DeleteFlag,
      IFNULL(a.corporationdscode,'')						AS LocalManufacturerName,
      IFNULL(MIN( M.updateDTS ),'1900-01-01') 				AS SRCLASTMODIFIEDDATE,
      HASH
      (
          IFNULL(RTRIM( M.MfrPartCode ),' '),
          IFNULL(M.MfrPartDescription,' '),
          IFNULL(C.ClassName,' '),
          IFNULL(CC.Category,' '),
          IFNULL(EJCS.classificationstatuscode,' '),
          IFNULL(M.DeleteFlag , 'FALSE'),
          IFNULL(MIN( M.updateDTS ),'1900-01-01')
      ) AS HASH_VALUE
  FROM 
      CONFORMED.SCMDB_MFRPART AS M
      INNER JOIN CONFORMED.SCMDB_CLASS C ON M.ClassID = C.ClassID
      INNER JOIN CONFORMED.SCMDB_CLASSCATEGORY CC ON C.ClassCategoryID = CC.ClassCategoryID    
      LEFT OUTER JOIN CONFORMED.SCMDB_CLASSIFICATIONSTATUS EJCS ON M.ClassificationStatusID = EJCS.ClassificationStatusID
      LEFT OUTER JOIN 
      (
        SELECT 
            mfrpartid, 
            mfrcorporationdsid, 
            corporationdscode,
            ROW_NUMBER() OVER 
            ( 
                  PARTITION BY 
                      a.mfrpartid 
                  ORDER BY 
                      cds.deleteflag DESC
              ) rn
        FROM 
            CONFORMED.SCMDB_AML a
            INNER JOIN CONFORMED.SCMDB_CORPORATIONDS cds ON a.mfrcorporationdsid = cds.corporationdsid
       ) a ON m.mfrpartid = a.mfrpartid 
          AND rn = 1
  GROUP BY 
      M.MfrPartCode,
      M.MfrPartDescription,
      C.ClassName,
      CC.Category,
      CASE 
          WHEN M.InternalStatusID = 1 THEN 'VERIFIED' 
          WHEN M.InternalStatusID = 2 THEN 'OBSOLETE'
          ELSE ''
      END,
      EJCS.classificationstatuscode,
      M.DeleteFlag,
      M.CorporationID,
      a.corporationdscode;