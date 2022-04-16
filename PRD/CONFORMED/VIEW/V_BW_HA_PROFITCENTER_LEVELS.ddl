create or replace view V_BW_HA_PROFITCENTER_LEVELS(
	PROFITCENTERCODE,
	PCHIERARCHY,
	CUSTOMERHIERARCHY,
	SECTORHIERARCHY,
	DIVISIONHIERARCHY,
	SEGMENTHIERARCHY
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
SELECT 
    PC.Child ProfitCenterCode
    , PC.Hierarchy PCHierarchy
    , MAX(CUS.Hierarchy) CustomerHierarchy
    , MAX(SEC.Hierarchy) SectorHierarchy
    , MAX(D.Hierarchy) DivisionHierarchy
    , MAX(SEG.Hierarchy) SegmentHierarchy
FROM
    CONFORMED.BW_HA_profitcenter_hierbridge pc
    LEFT OUTER JOIN CONFORMED.BW_HA_profitcenter_hierbridge CUS ON 
        CUS.ZLevel = 'CUS'
        AND CUS.Hierarchy = LEFT(PC.Hierarchy, length(CUS.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_profitcenter_hierbridge SEC ON 
        SEC.ZLevel = 'SEC'
        AND SEC.Hierarchy = LEFT(PC.Hierarchy, length(SEC.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_profitcenter_hierbridge D ON 
        D.ZLevel = 'DIV'
        AND D.Hierarchy = LEFT(PC.Hierarchy, length(D.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_profitcenter_hierbridge SEG ON 
        SEG.ZLevel = 'SEG'
        AND SEG.Hierarchy = LEFT(PC.Hierarchy, length(SEG.Hierarchy))
WHERE 
    PC.ZLevel = 'PCTR'
    AND PC.hierarchy LIKE 'TP0010%'
GROUP BY 
    PC.Child
    , PC.Hierarchy;