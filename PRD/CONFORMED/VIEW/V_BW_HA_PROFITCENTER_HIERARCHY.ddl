create or replace view V_BW_HA_PROFITCENTER_HIERARCHY(
	PROFITCENTERCODE,
	PROFITCENTERNAME,
	CUSTOMERCODE,
	CUSTOMERNAME,
	CUSTOMERGROUPCODE,
	CUSTOMERGROUPNAME,
	SECTORCODE,
	SECTORNAME,
	SEGMENTCODE,
	SEGMENTNAME,
	DIVISIONCODE,
	DIVISIONNAME,
	WORKCELLCODE,
	WORKCELLNAME,
	SUBSECTORCODE,
	SUBSECTORNAME
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimProfitCenterHierarchy
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Carlos Carrillo         Initial Revision
  */
SELECT DISTINCT 
    ProfitCenterCode
    , PCTR.txtlg ProfitCenterName
    , IFNULL(C.Child, 'UNDF') CustomerCode
    , IFNULL(C.ChildName, 'UNDF') CustomerName
    , IFNULL(CG.Child, 'UNDF') CustomerGroupCode
    , IFNULL(CG.ChildName, 'UNDF') CustomerGroupName
    , IFNULL(S.Child, 'UNDF') SectorCode
    , IFNULL(S.ChildName, 'UNDF') SectorName
    , IFNULL(SEG.Child, 'UNDF') SegmentCode
    , IFNULL(SEG.ChildName, 'UNDF') SegmentName
    , IFNULL(D.Child, 'UNDF') DivisionCode
    , IFNULL(D.ChildName, 'UNDF') DivisionName
    , IFNULL(WC.Child, 'UNDF') WorkCellCode
    , IFNULL(WC.ChildName, 'UNDF') WorkCellName
    , IFNULL(SS.Child, 'UNDF') SubSectorCode
    , IFNULL(SS.ChildName, 'UNDF') SubSectorName
FROM 
    CONFORMED.v_BW_HA_PROFITCENTER_LEVELS B
    INNER JOIN CONFORMED.BW_HA_PROFITCENTER_HIERDIM PCTR ON 
        B.ProfitCenterCode = PCTR.nodename
    INNER JOIN CONFORMED.v_BW_HA_PROFITCENTER_BASE C ON 
        C.Hierarchy = B.CustomerHierarchy
    INNER JOIN CONFORMED.v_BW_HA_PROFITCENTER_BASE S ON 
        S.Hierarchy = B.SectorHierarchy
    INNER JOIN CONFORMED.v_BW_HA_PROFITCENTER_BASE D ON 
        D.Hierarchy = B.DivisionHierarchy
    left JOIN CONFORMED.v_BW_HA_PROFITCENTER_BASE SEG ON -- Please return to INNER JOIN once in STG
        SEG.Hierarchy = B.SegmentHierarchy
    LEFT OUTER JOIN CONFORMED.v_BW_HA_PROFITCENTER_BASE WC ON 
        WC.Hierarchy = LEFT(B.PCHierarchy, length(B.PCHierarchy) - (length(B.ProfitCenterCode) + 1))
    LEFT OUTER JOIN CONFORMED.v_BW_HA_PROFITCENTER_BASE CG ON 
        CG.Hierarchy = CASE
                      WHEN C.Level_Number - S.Level_Number = 1 THEN C.Hierarchy
                      ELSE LEFT(C.Hierarchy, length(C.Hierarchy) - 11)
                  END
    LEFT OUTER JOIN CONFORMED.v_BW_HA_PROFITCENTER_BASE SS ON 
        SS.Hierarchy = CASE
                            WHEN abs(C.Level_Number - S.Level_Number) = 1 THEN S.Hierarchy
                        ELSE LEFT(C.Hierarchy, length(S.Hierarchy) + 11)
                  END;