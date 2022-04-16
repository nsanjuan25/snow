create or replace view V_FACTUTILIZATIONTWO(
	DATASOURCEKEY,
	PLANTKEY,
	ACTUALOPERATORHOURS,
	AVAILABLEHOURS,
	ACTRUNTIMEHOURS,
	ACTUALNOOFOPERAT,
	CALENDARDATEKEY,
	CALMONTH,
	CALWEEK,
	CALYEAR,
	ASSEMBLYCOST,
	YIELDTOCONF,
	PLANNEDDOWNTIMETIMEHOURS,
	PRODUCTIONDATEKEY,
	SEQGEN,
	SHIFT,
	TOTALMACHINES,
	DEPARTMENTCODE,
	PLANTCODE,
	CONFIRMEDSCRAP,
	PURCHASINGCOMPONENTCOST,
	PACKAGINGCOST,
	RESINCOLORANTCOST,
	ACTUALLABORCOST,
	STANDARDLABORCOST,
	UNPLANNEDDOWNTIMEHOURS,
	SRCLASTMODIFIEDDATE
) as
/*--------------------------------------------------------------------

This view is used to insert data into SAP.FactUtilizationTWO
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-22      Noel San Juan          Initial Revision
*/
SELECT 
      1							        AS DataSourceKey,
      IFNULL(DP.PlantKey,0)		        AS PlantKey,
      IFNULL(ESPU.actophrs,0)           AS ActualOperatorHours,
      IFNULL(ESPU.availhrs,0)           AS AvailableHours,
      IFNULL(ESPU.a_ism02,0)            AS ActRunTimeHours,
      IFNULL(ESPU.a_operators,0)        AS ActualNoofOperat,  
      CASE
        WHEN CAST(ESPU.calmonth AS varchar(6)) = '000000' THEN '1900-01-01'
        ELSE IFNULL(TRY_TO_DATE(CONCAT(CAST(ESPU.calmonth AS varchar(8)), '01'), 'YYYYMMDD' ), '1900-01-01')
      END                               AS CalendarDateKey,
      IFNULL(ESPU.calmonth,'')		    AS CalMonth,
      IFNULL(ESPU.calweek,'')			AS CalWeek,
      IFNULL(ESPU.calyear,'')			AS CalYear,
      IFNULL(ESPU.cstassy,0)            AS AssemblyCost,
      IFNULL(ESPU.lmnga,0)              AS Yieldtoconf,
      IFNULL(ESPU.pdt,0)                AS PlannedDowntimeTimeHours,
      CASE
          WHEN ESPU.prod_date = '00000000' THEN '1900-01-01'
          ELSE IFNULL (TRY_TO_DATE(ESPU.prod_date, 'YYYYMMDD' ), '1900-01-01')
      END								AS ProductionDateKey,
      IFNULL(ESPU.seqgen,0)			    AS seqgen,
      IFNULL(ESPU.shift,'')             AS Shift,
      IFNULL(ESPU.tm,0)                 AS TotalMachines,
      IFNULL(ESPU.veran,'')             AS DepartmentCode,
      IFNULL(ESPU.werks,'')             AS PlantCode,
      IFNULL(ESPU.xmnga,0)              AS ConfirmedScrap,
      IFNULL(ESPU.zcstpc,0)             AS PurchasingComponentCost,
      IFNULL(ESPU.zcstpkg,0)            AS PackagingCost,
      IFNULL(ESPU.zcstres,0)            AS ResinColorantCost,
      IFNULL(ESPU.zlabcst_a,0)          AS ActualLaborCost,
      IFNULL(ESPU.zlabcst_c,0)          AS StandardLaborCost,
      IFNULL(ESPU.zmdthrs,0)            AS UnplannedDowntimeHours,
      ESPU.SNFLK_UPDATEDON              AS SrcLastModifiedDate
  FROM 
      CONFORMED.BW_HA_PKG_UT2 AS ESPU
      LEFT OUTER JOIN SAP.DimPlants AS DP ON ESPU.werks = DP.PlantCode
          AND DP.DataSourceKey = 1;