create or replace view V_BW_HA_COSTCENTERHIERARCHY_20(
	COSTCENTERCODE,
	COSTCENTERNAME,
	PLANTCODE,
	PLANTNAME,
	SITECODE,
	SITENAME,
	CAMPUSCODE,
	CAMPUSNAME,
	COUNTRYCODE,
	COUNTRYNAME,
	REGIONCODE,
	REGIONNAME,
	UPDATEDON
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
    COALESCE(D.Child, 'UNDF') CountryCode,
    COALESCE(D.ChildName, 'UNDF') CountryName,
    COALESCE(R.Child, 'UNDF') RegionCode,
    COALESCE(R.ChildName, 'UNDF') RegionName,
    sysdate() as UpdatedOn
FROM 
    CONFORMED.V_BW_HA_COSTCENTER_LEVELS b
    INNER JOIN CONFORMED.BW_HA_COSTCENTER_HIERDIM CCTR ON B.CostCenterCode = CCTR.nodename AND CCTR.zlevel='CCTR'
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE P ON P.Hierarchy = B.PlantHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE S ON S.Hierarchy = B.SiteHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE C ON C.Hierarchy = B.CampusHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE D ON D.Hierarchy = B.CountryHierarchy
    LEFT JOIN CONFORMED.V_BW_HA_COSTCENTER_BASE R ON R.Hierarchy = B.RegionHierarchy
WHERE
    B.Structure='TM20'
    AND B.CCHierarchy NOT LIKE 'TM20|2CCTEMP%';