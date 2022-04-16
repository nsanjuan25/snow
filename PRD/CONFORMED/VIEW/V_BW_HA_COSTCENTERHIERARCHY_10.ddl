create or replace view V_BW_HA_COSTCENTERHIERARCHY_10(
	COSTCENTERCODE,
	COSTCENTERNAME,
	PLANTCODE,
	PLANTNAME,
	SITECODE,
	SITENAME,
	CAMPUSCODE,
	CAMPUSNAME,
	CONSOLIDATEDCAMPUSCODE,
	CONSOLIDATEDCAMPUSNAME,
	DIVISIONCODE,
	DIVISIONNAME,
	SUBREGIONCODE,
	SUBREGIONNAME,
	REGIONCODE,
	REGIONNAME,
	UPDATEON
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimCostCenterHierarchy
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-03      Carlos Carrillo         Initial Revision
  */
SELECT DISTINCT 
    CostCenterCode,
    CCTR.txtlg CostCenterName,
    COALESCE(P.Child, 'UNDF') PlantCode,
    COALESCE(P.ChildName, 'UNDF') PlantName,
    COALESCE(S.Child, 'UNDF') SiteCode,
    COALESCE(S.ChildName, 'UNDF') SiteName,
    COALESCE(C.Child, 'UNDF') CampusCode,
    COALESCE(C.ChildName, 'UNDF') CampusName,
    COALESCE(CASE WHEN CC.ZLEVEL='ELM' THEN C.Child ELSE CC.Child END, 'UNDF') ConsolidatedCampusCode,
    COALESCE(CASE WHEN CC.ZLEVEL='ELM' THEN C.ChildName ELSE CC.ChildName END, 'UNDF') ConsolidatedCampusName,
    COALESCE(D.Child, 'UNDF') DivisionCode,
    COALESCE(D.ChildName, 'UNDF') DivisionName,
    COALESCE(SR.Child, R.Child, 'UNDF') SubRegionCode,
    COALESCE(SR.ChildName, R.ChildName, 'UNDF') SubRegionName,
    COALESCE(R.Child, 'UNDF') RegionCode,
    COALESCE(R.ChildName, 'UNDF') RegionName,
    SYSDATE() AS UpdateOn
FROM 
    CONFORMED.V_BW_HA_COSTCENTER_LEVELS b
    INNER JOIN CONFORMED.BW_HA_COSTCENTER_HIERDIM CCTR ON B.CostCenterCode = CCTR.nodename AND CCTR.zlevel='CCTR'
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE P ON P.Hierarchy = B.PlantHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE S ON S.Hierarchy = B.SiteHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE C ON C.Hierarchy = B.CampusHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE D ON D.Hierarchy = B.DivisionHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE SR ON SR.Hierarchy = B.SubRegionHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE R ON R.Hierarchy = B.RegionHierarchy
    LEFT OUTER JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE CC
        ON CC.Hierarchy = CASE WHEN C.Level_Number - COALESCE(SR.Level_Number, D.Level_Number) = 1
                                    THEN C.Hierarchy
                                ELSE LEFT(C.Hierarchy, LENGTH(C.Hierarchy) - (LENGTH(C.Child)+1))
                            END
WHERE
    B.Structure='TM10';