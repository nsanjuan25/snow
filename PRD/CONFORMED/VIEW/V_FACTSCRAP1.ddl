create or replace view V_FACTSCRAP1(
	DATASOURCEKEY,
	WORKCENTER,
	ORDERNUMBER,
	ACTUALCAVITIES,
	ACTUALCYCLE,
	ACTUALRUNHOURS,
	ACTUALOPERATORS,
	CALMONTH,
	CALWEEK,
	CALYEAR,
	OPERATIONUNIT,
	LOTUNIT,
	REASON,
	CONTROLLINGAREA,
	ACTUALQTY,
	HOURLYLABORRATE,
	MATERIALKEY,
	MATERIAL,
	MATERIALPLANT,
	BASEUNIT,
	EQUIPMENT,
	PRODUCTIONDATEKEY,
	PROFITCENTER,
	PRODUCTION_DATE,
	TOTALSAMPLES,
	SHIFTDETAILS,
	SALESVALUEPER1000,
	STANDARDCAVITIES,
	STANDARDCYLE,
	STANDARDOPERATORS,
	PERSONRESPONSIBILE,
	CURRENCY,
	PLANTKEY,
	PLANT,
	CONFIRMEDSCRAP,
	ACTUALSCRAP,
	DOWNTIMECODE,
	SOURCELOCATION,
	LASTDATALOADTIMES,
	UNPLANNEDDOWNHRS,
	SALESVALUE,
	STDCAVITYHRS,
	UPDATEDON,
	PRICEMAT,
	PRICEUNIT
) as
/*--------------------------------------------------------------------

This view is used to insert data into SAP.FactScrap1
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-22      Noel San Juan          Initial Revision
*/
SELECT
	1											AS DataSourceKey,
    IFNULL(scrp.arbpl,'')						AS WorkCenter,
	IFNULL(scrp.aufnr,'')						AS OrderNumber,
    IFNULL(scrp.a_cavities,0)					AS ActualCavities, 
    IFNULL(scrp.a_cyc_time,0)					AS ActualCycle, 
    IFNULL(scrp.a_ism02,0)						AS ActualRunHours,
    IFNULL(scrp.a_operators,0)					AS ActualOperators, 
    IFNULL(scrp.calmonth,'')					AS CalMonth,
	IFNULL(scrp.calweek,'')						AS CalWeek, 
    IFNULL(scrp.calyear,'')						AS Calyear,
    IFNULL(scrp.gewei,'')						AS OperationUnit,
    IFNULL(scrp.gewei2,'')						AS LotUnit,
    IFNULL(scrp.grund,'')						AS Reason,
    IFNULL(scrp.kokrs,'')						AS ControllingArea,
    IFNULL(scrp.lmnga,0)						AS ActualQty,
    IFNULL(scrp.lrph,0)							AS HourlyLaborRate,
    IFNULL(DM.MaterialKey,0)					AS MaterialKey,
    IFNULL(scrp.matnr,'')						AS Material,
    IFNULL(scrp.mat_plant,'')					AS MaterialPlant,
    IFNULL(scrp.meinh,'')						AS BaseUnit,
    IFNULL(scrp.mold,'')						AS Equipment,
	CASE
		WHEN scrp.prod_date = '00000000' THEN '1900-01-01'
		ELSE IFNULL ( TRY_TO_DATE(scrp.prod_date, 'YYYYMMDD' ), '1900-01-01')
	END											AS ProductionDateKey,
    IFNULL(scrp.prctr,'')						AS ProfitCenter, 
    scrp.prod_date						        AS Production_Date,
    IFNULL(scrp.qs_qty,0)						AS TotalSamples,
    IFNULL(scrp.shift,'')						AS ShiftDetails,	  
    IFNULL(scrp.svpt,0)							AS SalesValuePer1000,
    IFNULL(scrp.s_cavities,0)					AS StandardCavities,
    IFNULL(scrp.s_cyc_time,0)					AS StandardCyle,
    IFNULL(scrp.s_operators,0)					AS StandardOperators,
    IFNULL(scrp.veran,'')						AS PersonResponsibile,
    IFNULL(scrp.waers,'')						AS Currency,
    IFNULL(DP.PlantKey,0)						AS PlantKey,
    IFNULL(scrp.werks,'')						AS Plant,
    IFNULL(scrp.xmnga,0)						AS ConfirmedScrap,
    IFNULL(scrp.xmnga_1,0)						AS ActualScrap,
    IFNULL(scrp.zdtcode,'')						AS DownTimeCode,
    IFNULL(scrp.zdtcode_1,'')					AS SourceLocation,
    IFNULL(scrp.zlstloadn,0)					AS LastDataLoadTimes,
    IFNULL(scrp.zmdthrs,0)						AS UnplannedDownHrs,
    IFNULL(scrp.zsalval,0)						AS SalesValue,
    IFNULL(scrp.zstdcavhr,0)					AS StdCavityHrs,
    scrp.SNFLK_UPDATEDON						AS UpdatedOn,
	IFNULL(scrp.pricemat,0)						AS PriceMat,
	IFNULL(scrp.priceunit,0)					AS PriceUnit
FROM
    CONFORMED.BW_HA_PKG_SCRAP1 AS SCRP
    LEFT OUTER JOIN SAP.DimPlants AS DP ON scrp.werks = DP.PlantCode
        AND DP.DataSourceKey = 1 -- Hardcoded for nyrpo
    LEFT OUTER JOIN SAP.DimMaterials AS DM ON scrp.matnr = DM.MaterialCode
        AND DM.PlantKey = DP.PlantKey
        AND DM .DataSourceKey = 1;