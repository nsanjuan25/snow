create or replace view V_DIMPROFITCENTERHIERARCHY(
	PROFITCENTERCODE,
	PROFITCENTERNAME,
	WORKCELLCODE,
	WORKCELLNAME,
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
SELECT 	
      ProfitCenterCode
	, ProfitCenterName
	, WorkCellCode
	, WorkCellName
	, CustomerCode
	, CustomerName
	, CustomerGroupCode
	, CustomerGroupName
	, SectorCode
	, SectorName
	, SegmentCode
	, SegmentName
	, DivisionCode
	, DivisionName
	, SubSectorCode
	, SubSectorName
FROM 
    CONFORMED.v_BW_HA_PROFITCENTER_HIERARCHY;