create or replace view V_DIMMATERIALGROUPS(
	DATASOURCEKEY,
	MATERIALGROUPCODE,
	CORPORATIONID,
	MATERIALGROUPTYPECODE,
	GLOBALMATERIALGROUPNAME,
	LOCALMATERIALGROUPNAME,
	LOCALMATERIALGROUPNAME2,
	LOCALMATERIALGROUPNAME3,
	LOCALMATERIALGROUPNAME4,
	DELETEFLAG,
	RN
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimMaterialGroups
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Juan Cedeno             Initial Revision
2021-07-30      Jagan                   Add JPS
2021-09-22      Jagan                   Add PLA
*/                            

SELECT 
    *
FROM                        
    (                        
      SELECT 
            1 as DataSourceKey
          , MaterialGroupCode
          , CorporationID
          , MaterialGroupTypeCode
          , GlobalMaterialGroupName
          , LocalMaterialGroupName
          , LocalMaterialGroupName2
          , LocalMaterialGroupName3
          , LocalMaterialGroupName4
          , DeleteFlag    
          , row_number() over(partition by MaterialGroupCode order by MaterialGroupCode) rn
      FROM 
          conformed.v_ECC_HA_DimMaterialGroups           

      UNION ALL 

      SELECT 
            2 as DataSourceKey
          , MaterialGroupCode
          , CorporationID
          , MaterialGroupTypeCode
          , GlobalMaterialGroupName
          , LocalMaterialGroupName
          , LocalMaterialGroupName2
          , LocalMaterialGroupName3
          , LocalMaterialGroupName4
          , DeleteFlag    
          , row_number() over(partition by MaterialGroupCode order by MaterialGroupCode) rn
      FROM 
          conformed.v_HCC_HA_DimMaterialGroups
		  
	  UNION ALL 

      SELECT 
            5 as DataSourceKey
          , MaterialGroupCode
          , CorporationID
          , MaterialGroupTypeCode
          , GlobalMaterialGroupName
          , LocalMaterialGroupName
          , LocalMaterialGroupName2
          , LocalMaterialGroupName3
          , LocalMaterialGroupName4
          , DeleteFlag    
          , row_number() over(partition by MaterialGroupCode order by MaterialGroupCode) rn
      FROM 
          conformed.v_JPS_HA_DimMaterialGroups

	  UNION ALL 

      SELECT 
            4 as DataSourceKey
          , MaterialGroupCode
          , CorporationID
          , MaterialGroupTypeCode
          , GlobalMaterialGroupName
          , LocalMaterialGroupName
          , LocalMaterialGroupName2
          , LocalMaterialGroupName3
          , LocalMaterialGroupName4
          , DeleteFlag    
          , row_number() over(partition by MaterialGroupCode order by MaterialGroupCode) rn
      FROM 
          conformed.v_PLA_HA_DimMaterialGroups

    )Q
WHERE 
    Q.rn = 1;