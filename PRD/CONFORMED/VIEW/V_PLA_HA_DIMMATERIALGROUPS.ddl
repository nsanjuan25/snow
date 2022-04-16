create or replace view V_PLA_HA_DIMMATERIALGROUPS(
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
2021-09-21      Jagan                   Initial Revision
*/                        
SELECT 
      IFNULL(trim(t023.MATKL),'UNDF') AS MaterialGroupCode
    , 0                               AS CorporationID
    , 'MATLGROUP'                     AS MaterialGroupTypeCode
    , 'UNDF'                          as GlobalMaterialGroupName
    , IFNULL(t023t.wgbez   , '' )     AS LocalMaterialGroupName
    , IFNULL(t023t.wgbez60 , '' )     AS LocalMaterialGroupName2
    , ''                              AS LocalMaterialGroupName3
    , ''                              AS LocalMaterialGroupName4
    , 'FALSE'                         AS DeleteFlag                        
FROM  
      conformed.PLA_HA_T023 t023
LEFT OUTER JOIN 
      conformed.PLA_HA_T023T t023t 
   	     on t023.Mandt = t023t.Mandt
        and t023.MATKL = t023t.MATKL
        and t023t.spras = 'E';