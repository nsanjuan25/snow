create or replace view V_DIMINVENTORYLOCATIONS(
	PLANTCODE,
	INVENTORYLOCATIONCODE,
	DATASOURCEKEY,
	INVENTORYLOCATIONNAME,
	MRPINDICATOR,
	INVENTORYLOCATIONTYPECODE,
	INVENTORYLOCATIONTYPEDESCRIPTION,
	INVENTORYLOCATIONTYPESTANDARDCODE,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------------------------

This view is used to do the ADD data to DIMEXCHANGERATES
----------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------
2021-02-04      Carlos Carrillo         Initial Revision
2021-07-14      Jagan                   Add JPS
2021-09-22      Jagan                   Add PLA
*/
  
SELECT 
       ifnull(TRIM(SiteCode), '') AS PlantCode
     , ifnull(TRIM(InventoryLocationCode), '') AS InventoryLocationCode
     , 1 AS DataSourceKey
     , InventoryLocation.LocationName AS InventoryLocationName
     , InventoryLocation.MRPFlag AS MRPIndicator
     , TRIM(IFNULL(LocationType.LocationTypeCode, 'Undefined')) AS InventoryLocationTypeCode
     , IFNULL(LocationType.Description, 'Undefined Inventory Location Type') AS InventoryLocationTypeDescription
     , IFNULL(InventoryLocationTypeStd.LocationTypeStdCode, 'Undefined') AS InventoryLocationTypeStandardCode
     , InventoryLocation.Updated_ON AS SrclastModifiedDate
     , HASH(InventoryLocation.LocationName, InventoryLocationTypeStd.LocationTypeStdCode) AS HASH_VALUE
FROM
   (
    SELECT 
	       ALLROWS.rn
         , ALLROWS.SiteCode
         , ALLROWS.InventoryLocationCode
         , ALLROWS.InventoryLocationTypeCode
         , ALLROWS.LocationName
         , ALLROWS.MRPFlag
         , ALLROWS.Updated_ON
    FROM
       (
        SELECT 
		       ROW_NUMBER() OVER (PARTITION BY IL.SiteCode, Location ORDER BY IL.Updated_On DESC) rn
             , IL.SiteCode AS SiteCode
             , IL.Location AS InventoryLocationCode
             , IFNULL(M.LocationTypeCode, 'Undefined') AS InventoryLocationTypeCode
             , IL.LocationName
             , IL.MRPFlag
             , IL.Updated_On
        FROM 
		       CONFORMED.V_ECC_HA_DIMINVENTORYLOCATION IL
        LEFT OUTER JOIN 
		       SAP.DimInventoryLocationTypeMaps M
                  ON  RTRIM(IL.LocationName) LIKE RTRIM(M.LikeSearchString)
                  AND RTRIM(IL.LocationName) NOT LIKE RTRIM(M.NotLikeSearchString)
        ) ALLROWS
    WHERE 
	      ALLROWS.rn = 1
    ) InventoryLocation
    LEFT OUTER JOIN 
	     CONFORMED.SCMDB_inventorylocationtype LocationType
             ON  InventoryLocation.InventoryLocationTypeCode = LocationType.LocationTypeCode
             AND LocationType.DataSourceID = 6
    LEFT OUTER JOIN 
	     CONFORMED.SCMDB_inventorylocationtypeSTD InventoryLocationTypeStd
             ON LocationType.LocationTypeStdID = InventoryLocationTypeStd.LocationtYPEStdID
UNION ALL

SELECT 
       IFNULL(TRIM(SiteCode), '') AS PlantCode
     , IFNULL(TRIM(InventoryLocationCode), '') AS InventoryLocationCode
     , 2 AS DataSourceKey
     , InventoryLocation.LocationName AS InventoryLocationName
     , InventoryLocation.MRPFlag AS MRPIndicator
     , TRIM(IFNULL(LocationType.LocationTypeCode, 'Undefined')) AS InventoryLocationTypeCode
     , IFNULL(LocationType.Description, 'Undefined Inventory Location Type') AS InventoryLocationTypeDescription
     , IFNULL(InventoryLocationTypeStd.LocationTypeStdCode, 'Undefined') AS InventoryLocationTypeStandardCode
     , InventoryLocation.Updated_On AS SrclastModifiedDate
     , HASH(InventoryLocation.LocationName, InventoryLocationTypeStd.LocationTypeStdCode) AS HASH_VALUE
FROM
   (
    SELECT 
	       ALLROWS.rn
         , ALLROWS.SiteCode
         , ALLROWS.InventoryLocationCode
         , ALLROWS.InventoryLocationTypeCode
         , ALLROWS.LocationName
         , ALLROWS.MRPFlag
         , ALLROWS.Updated_ON
    FROM
        (
        SELECT 
		       ROW_NUMBER() OVER (PARTITION BY IL.SiteCode, Location ORDER BY IL.Updated_On DESC) rn
             , IL.SiteCode AS SiteCode
             , IL.Location AS InventoryLocationCode
             , IFNULL(M.LocationTypeCode, 'Undefined') AS InventoryLocationTypeCode
             , IL.LocationName
             , IL.MRPFlag
             , IL.Updated_On
        FROM   
		       CONFORMED.V_HCC_HA_DIMINVENTORYLOCATIONS IL
        LEFT OUTER JOIN 
		       SAP.DimInventoryLocationTypeMaps M
                   ON  RTRIM(IL.LocationName) LIKE RTRIM(M.LikeSearchString)
                   AND RTRIM(IL.LocationName) NOT LIKE RTRIM(M.NotLikeSearchString)
        ) ALLROWS
    WHERE 
	      ALLROWS.rn = 1
    ) InventoryLocation
    LEFT OUTER JOIN 
	       CONFORMED.SCMDB_inventorylocationtype LocationType
               ON  InventoryLocation.InventoryLocationTypeCode = LocationType.LocationTypeCode
               AND LocationType.DataSourceID = 6
    LEFT OUTER JOIN 
	       CONFORMED.SCMDB_inventorylocationtypeSTD InventoryLocationTypeStd
               ON LocationType.LocationTypeStdID = InventoryLocationTypeStd.LocationtYPEStdID
UNION ALL

SELECT 
       ifnull(TRIM(SiteCode), '') AS PlantCode
     , ifnull(TRIM(InventoryLocationCode), '') AS InventoryLocationCode
     , 5 AS DataSourceKey
     , InventoryLocation.LocationName AS InventoryLocationName
     , InventoryLocation.MRPFlag AS MRPIndicator
     , TRIM(IFNULL(LocationType.LocationTypeCode, 'Undefined')) AS InventoryLocationTypeCode
     , IFNULL(LocationType.Description, 'Undefined Inventory Location Type') AS InventoryLocationTypeDescription
     , IFNULL(InventoryLocationTypeStd.LocationTypeStdCode, 'Undefined') AS InventoryLocationTypeStandardCode
     , InventoryLocation.Updated_ON AS SrclastModifiedDate
     , HASH(InventoryLocation.LocationName, InventoryLocationTypeStd.LocationTypeStdCode) AS HASH_VALUE
    FROM
       (
        SELECT 
		       ALLROWS.rn
             , ALLROWS.SiteCode
             , ALLROWS.InventoryLocationCode
             , ALLROWS.InventoryLocationTypeCode
             , ALLROWS.LocationName
             , ALLROWS.MRPFlag
             , ALLROWS.Updated_ON
        FROM
            (
            SELECT 
			       ROW_NUMBER() OVER (PARTITION BY IL.SiteCode, Location ORDER BY IL.Updated_On DESC) rn
                 , IL.SiteCode AS SiteCode
                 , IL.Location AS InventoryLocationCode
                 , IFNULL(M.LocationTypeCode, 'Undefined') AS InventoryLocationTypeCode
                 , IL.LocationName
                 , IL.MRPFlag
                 , IL.Updated_On
            FROM   
			       CONFORMED.V_JPS_HA_DIMINVENTORYLOCATION IL
            LEFT OUTER JOIN 
			       SAP.DimInventoryLocationTypeMaps M
                       ON  RTRIM(IL.LocationName) LIKE RTRIM(M.LikeSearchString)
                       AND RTRIM(IL.LocationName) NOT LIKE RTRIM(M.NotLikeSearchString)
            ) ALLROWS
        WHERE 
		      ALLROWS.rn = 1
        ) InventoryLocation
        LEFT OUTER JOIN 
		       CONFORMED.SCMDB_inventorylocationtype LocationType
                   ON  InventoryLocation.InventoryLocationTypeCode = LocationType.LocationTypeCode
                   AND LocationType.DataSourceID = 6
        LEFT OUTER JOIN 
		       CONFORMED.SCMDB_inventorylocationtypeSTD InventoryLocationTypeStd
                   ON LocationType.LocationTypeStdID = InventoryLocationTypeStd.LocationtYPEStdID

UNION ALL

SELECT 
       ifnull(TRIM(SiteCode), '') AS PlantCode
     , ifnull(TRIM(InventoryLocationCode), '') AS InventoryLocationCode
     , 4 AS DataSourceKey
     , InventoryLocation.LocationName AS InventoryLocationName
     , InventoryLocation.MRPFlag AS MRPIndicator
     , TRIM(IFNULL(LocationType.LocationTypeCode, 'Undefined')) AS InventoryLocationTypeCode
     , IFNULL(LocationType.Description, 'Undefined Inventory Location Type') AS InventoryLocationTypeDescription
     , IFNULL(InventoryLocationTypeStd.LocationTypeStdCode, 'Undefined') AS InventoryLocationTypeStandardCode
     , InventoryLocation.Updated_ON AS SrclastModifiedDate
     , HASH(InventoryLocation.LocationName, InventoryLocationTypeStd.LocationTypeStdCode) AS HASH_VALUE
    FROM
       (
        SELECT 
		       ALLROWS.rn
             , ALLROWS.SiteCode
             , ALLROWS.InventoryLocationCode
             , ALLROWS.InventoryLocationTypeCode
             , ALLROWS.LocationName
             , ALLROWS.MRPFlag
             , ALLROWS.Updated_ON
        FROM
            (
            SELECT 
			       ROW_NUMBER() OVER (PARTITION BY IL.SiteCode, Location ORDER BY IL.Updated_On DESC) rn
                 , IL.SiteCode AS SiteCode
                 , IL.Location AS InventoryLocationCode
                 , IFNULL(M.LocationTypeCode, 'Undefined') AS InventoryLocationTypeCode
                 , IL.LocationName
                 , IL.MRPFlag
                 , IL.Updated_On
            FROM   
			       CONFORMED.V_PLA_HA_DIMINVENTORYLOCATION IL
            LEFT OUTER JOIN 
			       SAP.DimInventoryLocationTypeMaps M
                       ON  RTRIM(IL.LocationName) LIKE RTRIM(M.LikeSearchString)
                       AND RTRIM(IL.LocationName) NOT LIKE RTRIM(M.NotLikeSearchString)
            ) ALLROWS
        WHERE 
		      ALLROWS.rn = 1
        ) InventoryLocation
        LEFT OUTER JOIN 
		       CONFORMED.SCMDB_inventorylocationtype LocationType
                   ON  InventoryLocation.InventoryLocationTypeCode = LocationType.LocationTypeCode
                   AND LocationType.DataSourceID = 6
        LEFT OUTER JOIN 
		       CONFORMED.SCMDB_inventorylocationtypeSTD InventoryLocationTypeStd
                   ON LocationType.LocationTypeStdID = InventoryLocationTypeStd.LocationtYPEStdID
;