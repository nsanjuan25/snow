create or replace view V_FACTCOGS(
	DATASOURCEKEY,
	PLANTKEY,
	CALENDARDAYKEY,
	CONTROLLINGAREA,
	MATERIALCOSTPER000,
	LABORCOST,
	OVERHEADCOST,
	MATERIALKEY,
	MATERIAL,
	MATERIALPLANT,
	PROFITCENTERCODE,
	CURRENCYCODE,
	PLANT,
	SRCLASTMODIFIEDDATE
) as
/*--------------------------------------------------------------------

This view is used to insert data into SAP.FACTCOGS
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-22      Noel San Juan           Initial Revision
*/
SELECT
	1								AS DataSourceKey,
	IFNULL(DP.PlantKey,0)           AS PlantKey,
	CASE
		WHEN scrp.calday = '00000000' THEN '1900-01-01'
		ELSE IFNULL ( TRY_TO_DATE(scrp.calday, 'YYYYMMDD' ), '1900-01-01')
	END								AS CalendarDayKey,
    IFNULL(scrp.kokrs,'')			AS ControllingArea,
    IFNULL(scrp.kst01,0)			AS MaterialCostPer000,
    IFNULL(scrp.kst02,0)			AS LaborCost,
    IFNULL(scrp.kst03,0)			AS OverHeadCost,
    IFNULL(DM.MaterialKey,0)        AS MaterialKey,
    IFNULL(scrp.matnr,'')			AS Material,
    IFNULL(scrp.mat_plant,'')		AS MaterialPlant,
    IFNULL(scrp.prctr,'')			AS ProfitCenterCode,
    IFNULL(scrp.waers,'')			AS CurrencyCode,
    IFNULL(scrp.werks,'')			AS Plant,
    SCRP.SNFLK_UPDATEDON            AS SrcLastModifiedDate
FROM
    CONFORMED.BW_HA_PKG_SCRAP2 AS SCRP
    LEFT OUTER JOIN SAP.DimPlants AS DP ON SCRP.werks = DP.PlantCode
        AND DP.DataSourceKey = 1 --> Hardcoded due to Nypro no multisourcing
    LEFT OUTER JOIN SAP.DimMaterials AS DM ON SCRP.matnr = DM.MaterialCode
        AND DP.PlantKey = DM.PlantKey
        AND DM.DataSourceKey = 1;