create or replace view V_ECC_HA_DIMMATERIALGROUPS(
	DATASOURCEKEY,
	MATERIALGROUPCODE,
	CORPORATIONID,
	MATERIALGROUPTYPECODE,
	GLOBALMATERIALGROUPNAME,
	LOCALMATERIALGROUPNAME,
	LOCALMATERIALGROUPNAME2,
	LOCALMATERIALGROUPNAME3,
	LOCALMATERIALGROUPNAME4,
	DELETEFLAG
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.v_DimMaterialGroups
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Juan Cedeno             Initial Revision
*/                        

SELECT
     dd.DataSourceKey	
   , IFNULL( trim(C.CorporationDSCode),'UNDF')  AS MaterialGroupCode
   , IFNULL(C.CorporationID,0)                  AS CorporationID 
   , UPPER( ds.CorporationDSTypeCode )          AS MaterialGroupTypeCode 
   , IFNULL(GC.CorporationName,'')              AS GlobalMaterialGroupName
   , IFNULL(C.CorporationDSName,'')             AS LocalMaterialGroupName
   , IFNULL(C.CorporationDSName2,'')            AS LocalMaterialGroupName2
   , IFNULL(C.CorporationDSName3,'')            AS LocalMaterialGroupName3
   , IFNULL(C.CorporationDSName4,'')            AS LocalMaterialGroupName4
   , IFNULL(C.DeleteFlag, 'FALSE' )             AS DeleteFlag
FROM
   conformed.scmdb_CorporationdS C
   INNER JOIN conformed.scmdb_Corporation GC  ON GC.CorporationID = C.CorporationID
   INNER JOIN conformed.scmdb_CorporationDSType ds on C.CorporationDSTypeID = ds.CorporationDSTypeID
        AND C.DataSourceId = DS.DataSourceId
   INNER JOIN conformed.scmdb_CorporationDSTypeStd std ON ds.CorporationDSTypeStdID = std.CorporationDSTypeStdID
   INNER JOIN public.DimDataSources dd ON DD.JDB_DataSourceId = C.DataSourceID
WHERE 
    std.CorporationDSTypeStdCode = 'MaterialGroup';