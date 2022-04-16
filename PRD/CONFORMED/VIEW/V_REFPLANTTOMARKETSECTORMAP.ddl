create or replace view V_REFPLANTTOMARKETSECTORMAP(
	DATASOURCEKEY,
	MATERIALGROUPKEY,
	MARKETSECTORKEY,
	PLANTKEY,
	SRCLASTMODIFIEDDATE
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into v_RefPlantToMarketSectorMAP
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-05     SRIDHAR                 Initial Revision            
*/       


Select 
	* 
FROM 
(
	SELECT 
		  vrefpms.dataSourceKey         as dataSourceKey
		, IFNULL(dc.MaterialGroupKey,0) as MaterialGroupKey
		, IFNULL(MS.MarketSectorKey,0)  as MarketSectorKey
		, IFNULL(DP.PlantKey,0)         as PlantKey
		, SNFLK_UPDATEDON               as SrclastModifiedDate
  FROM 
		CONFORMED.v_RefPlantToMarketSector vrefpms
		INNER JOIN SAP.DimMaterialGroups dc
			ON dc.MaterialGroupCode = vrefpms.MaterialGroupCode
            and  dc.DataSourceKey = vrefpms.DataSourceKey  
		INNER JOIN SAP.DimMarketSectors MS
			ON  MS.MarketSector = vrefpms.MarketSector 
            and MS.DataSourceKey = vrefpms.DataSourceKey  
		INNER JOIN SAP.DimPlants DP
			ON DP.PlantCode = vrefpms.SiteCode
            AND DP.DataSourcekey = vrefpms.DataSourceKey
    ) CombinedDims;