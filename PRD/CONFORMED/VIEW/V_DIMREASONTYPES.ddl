create or replace view V_DIMREASONTYPES(
	REASONTYPECODE,
	MOVEMENTTYPEKEY,
	DATASOURCEKEY,
	DESCRIPTION,
	REASONTYPESTANDARDCODE,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DIMREASONTYPES
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-17      Carlos Carrillo         Initial Revision
  */
    SELECT 
		  CAST(ReasonTypeCode AS varchar) AS ReasonTypeCode
		, IFNULL(dimmovementtypes.MovementTypeKey,0) as MovementTypeKey
		, (select DataSourceKey from PUBLIC.DimDataSources where DataSourceName='SAP') as DataSourceKey
		, Description
		, ReasonTypeStdCode as ReasonTypeStandardCode
		, reasontype.snflk_UpdatedOn as SrcLastModifiedDate
		, HASH(dimmovementtypes.MovementTypeKey,Description,ReasonTypeStdCode) as HASH_VALUE
	FROM 
		(
			SELECT DISTINCT 
				  ReasonTypeCode
				, MovementTypeCode
				, ReasonTypeStdId
				, Description
				, snflk_UpdatedOn 
			FROM 
				CONFORMED.SCMDB_ReasonType  
			WHERE 
				DataSourceID = 6
		) reasontype
		LEFT OUTER JOIN CONFORMED.SCMDB_ReasonTypeStd reasontypestd ON reasontype.ReasonTypeStdID = reasontypestd.ReasonTypeStdID
		LEFT OUTER JOIN SAP.DimMovementTypes dimmovementtypes ON reasontype.MovementTypeCode = dimmovementtypes.MovementTypeCode
															  AND dimmovementtypes.DataSourceKey = 1;