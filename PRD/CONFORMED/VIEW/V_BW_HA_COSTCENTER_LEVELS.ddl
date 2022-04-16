create or replace view V_BW_HA_COSTCENTER_LEVELS(
	STRUCTURE,
	COSTCENTERCODE,
	CCHIERARCHY,
	PLANTHIERARCHY,
	SITEHIERARCHY,
	CAMPUSHIERARCHY,
	SUBREGIONHIERARCHY,
	REGIONHIERARCHY,
	DIVISIONHIERARCHY,
	COUNTRYHIERARCHY
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
SELECT 
    LEFT(CC.hierarchy,4) Structure,
    CC.Child CostCenterCode,
    CC.Hierarchy CCHierarchy,
    max(PLT.Hierarchy) PlantHierarchy,
    max(SIT.Hierarchy) SiteHierarchy,
    max(MPT.Hierarchy) CampusHierarchy,
    max(SRG.Hierarchy) SubRegionHierarchy,
    max(REG.Hierarchy) RegionHierarchy,
    max(D.Hierarchy) DivisionHierarchy,
    max(CTY.Hierarchy) CountryHierarchy
FROM
    CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE CC
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE PLT ON 
        PLT.ZLevel = 'PLT'
        AND PLT.Hierarchy = LEFT(CC.Hierarchy, length(PLT.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE SIT ON 
        SIT.ZLevel = 'SIT'
        AND SIT.Hierarchy = LEFT(CC.Hierarchy, length(SIT.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE MPT ON 
        MPT.ZLevel = 'MPT'
        AND MPT.Hierarchy = LEFT(CC.Hierarchy, length(MPT.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE SRG ON 
        SRG.ZLevel = 'SRG'
        AND SRG.Hierarchy = LEFT(CC.Hierarchy, length(SRG.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE REG ON 
        REG.ZLevel = 'REG'
        AND REG.Hierarchy = LEFT(CC.Hierarchy, length(REG.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE D ON 
        D.ZLevel = 'DIV'
        AND D.Hierarchy = LEFT(CC.Hierarchy, length(D.Hierarchy))
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE CTY ON 
        CTY.ZLevel = 'CTY'
        AND CTY.Hierarchy = LEFT(CC.Hierarchy, length(CTY.Hierarchy))
WHERE CC.ZLevel = 'CCTR'
GROUP BY
    LEFT(CC.hierarchy,4),
    CC.Child,
    CC.Hierarchy;