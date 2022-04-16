create or replace view V_DIMCOSTCENTERSTRUCTURE(
	DIVISIONCODE,
	DIVISIONNAME,
	REGIONCODE,
	REGIONNAME,
	PLANTKEY,
	PLANTCODE,
	PLANTNAMELONG,
	PLANTDESCRIPTION,
	PLANTNAME,
	CAMPUSKEY,
	CAMPUSDESCRIPTION,
	REGIONKEY,
	GEOREGION,
	COSTCENTERCODE,
	COSTCENTERNAME
) as
/*--------------------------------------------------------------------
 
This view is used in TM1Details view
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-04-08      Lakshman               Initial Revision
2021-04-28      Noel San Juan          Rectified code based on PROD logic
*/
SELECT
	CC.DivisionCode,
	CC.DivisionName,
	CC.RegionCode,
	CC.RegionName,
	P.PlantKey,
	CC.PlantCode,
	P.PlantNameLong,
	IFNULL(CONCAT(P.PlantCode, ' - ', P.PlantNameLong), CC.PlantName) AS PlantDescription,
	CC.PlantName,
	CA.CampusKey,
	IFNULL(CA.CampusDescription,CC.CampusName) AS CampusDescription,
	DR.RegionKey,
	DR.RegionDescription AS GeoRegion,
	CC.CostCenterCode,
	CC.CostCenterName
FROM
    TM1.DIMCOSTCENTERHIERARCHY CC
    LEFT OUTER JOIN SAP.DimPlants P ON CC.PlantCode = P.PlantCode
		AND P.DataSourceKey = 1
    LEFT OUTER JOIN SAP.DimCampus CA ON P.CampusCode = CA.CampusCode
    LEFT OUTER JOIN SAP.DimRegions DR ON CA.RegionKey = DR.RegionKey;