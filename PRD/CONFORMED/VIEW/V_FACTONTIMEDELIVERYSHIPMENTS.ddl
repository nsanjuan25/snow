create or replace view V_FACTONTIMEDELIVERYSHIPMENTS(
	PERIODSTARTDATEKEY,
	CALMONDESC,
	CALMONTH,
	CALYEAR,
	FISCALMONTH,
	FISCALYEAR,
	PERIODSTARTDATEKEY1,
	SITENAME,
	OTD_ACTUAL,
	OTD_TARGET,
	UTIL_ACTUAL,
	UTIL_TARGET,
	OEE_ACTUAL,
	OEE_TARGET,
	SCRAP_ACTUAL,
	SCRAP_TARGET,
	LSS_ACTUAL,
	LSS_TARGET,
	LOT_STANDARD,
	LOT_ACTUAL,
	LOT_TARGET,
	TOTAL_SHIPMENTS,
	TOTAL_LATE_SHIPMENTS,
	TOTAL_AVAILABLE_HOURS,
	TOTAL_ACTIVE_HOURS,
	AVAILABILITY_PECENT,
	PERFORMANCE_PERCENT,
	QUALITY_PERCENT,
	SCRAP_TOT_PARTS,
	SCRAP_TOT_DEF,
	DPPM_TARGET,
	DPPM_TOTAL_PARTS,
	DPPM_TOTAL_DAMAGED,
	TURNOVER_TARGET,
	TURNOVER_STAFF_BEG_MONTH,
	TURNOVER_HIRES_DURING_MONTH,
	TURNOVER_STAFF,
	SRCLASTMODIFIEDDATE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.FACTONTIMEDELIVERYSHIPMENTS table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-04-12      Noel San Juan          Initial Revision
*/
SELECT
    CASE
		WHEN a.PeriodStartDateKey1 = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(a.PeriodStartDateKey1, 'YYYYMMDD' ), '1900-01-01')
	END AS PeriodStartDateKey,
    a.*
FROM
(
  SELECT
      IFNULL(OTD.calmondesc,'')			AS calmondesc,
      IFNULL(OTD.calmonth,0)			AS calmonth,
      IFNULL(OTD.calyear,0)				AS calyear,
      IFNULL(OTD.fiscalmonth,0)			AS fiscalmonth,
      IFNULL(OTD.fiscalyear,0)			AS fiscalyear,
      CASE 
          WHEN LEN(OTD.calmonth) = 1 THEN CONCAT(OTD.calyear, '0', OTD.calmonth,'01') 
          ELSE CONCAT(OTD.calyear,OTD.calmonth, '01') 
      END AS PeriodStartDateKey1,
      IFNULL(UPPER(RTRIM(OTD.site )),'')AS SiteName,
      CASE
		  WHEN OTD.otd_Actual = 'NULL' OR  OTD.otd_Actual = '' THEN 0
		  ELSE IFNULL(OTD.otd_Actual,0)
      END AS Otd_Actual,
      CASE
          WHEN OTD.otd_Target = 'NULL' OR OTD.otd_Target = '' THEN 0
          ELSE IFNULL(OTD.otd_Target,0)	
      END AS Otd_Target,
      CASE
          WHEN OTD.util_actual = 'NULL' OR  OTD.util_actual = '' THEN 0
          ELSE IFNULL(OTD.util_actual,0)	
      END AS Util_Actual,
      CASE
          WHEN OTD.util_target = 'NULL' OR OTD.util_target = '' THEN 0
          ELSE IFNULL(OTD.util_target,0)	
      END AS Util_Target,
      CASE
          WHEN OTD.oee_actual = 'NULL' OR OTD.oee_actual = '' THEN 0
          ELSE IFNULL(OTD.oee_actual,0)	
      END AS Oee_Actual,
      CASE
          WHEN OTD.oee_target = 'NULL' OR OTD.oee_target = '' THEN 0
          ELSE IFNULL(OTD.oee_target,0)	
      END AS Oee_Target,
      CASE
          WHEN OTD.scrap_actual = 'NULL' OR OTD.scrap_actual = '' THEN 0
          ELSE IFNULL(OTD.scrap_actual,0)	
      END AS Scrap_Actual,
      CASE
          WHEN OTD.Scrap_Target = 'NULL' OR OTD.Scrap_Target = '' THEN 0
          ELSE IFNULL(OTD.Scrap_Target,0)	
      END AS Scrap_Target,
      CASE
          WHEN OTD.Lss_Actual = 'NULL'  OR OTD.Lss_Actual = ''THEN 0
          ELSE IFNULL(OTD.Lss_Actual,0)	
      END AS Lss_Actual,
      CASE
          WHEN OTD.Lss_Target = 'NULL' OR OTD.Lss_Target = '' THEN 0
          ELSE IFNULL(OTD.Lss_Target,0)	
      END AS Lss_Target,
      CASE
          WHEN OTD.lot_std_valadd_actual = 'NULL' OR OTD.lot_std_valadd_actual = '' THEN 0
          ELSE IFNULL(OTD.lot_std_valadd_actual,0)	
      END AS Lot_Standard,
      CASE
          WHEN OTD.lot_act_valadd_actual = 'NULL' OR OTD.lot_act_valadd_actual = '' THEN 0
          ELSE IFNULL(OTD.lot_act_valadd_actual,0)	
      END AS Lot_Actual,
      CASE
          WHEN OTD.lot_target = 'NULL' OR OTD.lot_target = '' THEN 0
          ELSE IFNULL(OTD.lot_target,0)	
      END AS Lot_Target,
      CASE
          WHEN OTD.total_shipments = 'NULL' OR OTD.total_shipments = '' THEN 0
          ELSE IFNULL(OTD.total_shipments,0)	
      END AS total_shipments,
      CASE
          WHEN OTD.total_late_shipments = 'NULL' OR OTD.total_late_shipments = '' THEN 0
          ELSE IFNULL(OTD.total_late_shipments,0)	
      END AS total_late_shipments,
      CASE
          WHEN OTD.total_available_hours = 'NULL' OR OTD.total_available_hours = '' THEN 0
          ELSE IFNULL(OTD.total_available_hours,0)	
      END AS total_available_hours,
      CASE
          WHEN OTD.total_active_hours = 'NULL' OR OTD.total_active_hours = '' THEN 0
          ELSE IFNULL(OTD.total_active_hours,0)	
      END AS total_active_hours,
      CASE
          WHEN OTD.availability_pecent = 'NULL' OR OTD.availability_pecent = '' THEN 0
          ELSE IFNULL(OTD.availability_pecent,0)	
      END AS availability_pecent,
      CASE
          WHEN OTD.performance_percent = 'NULL'  OR OTD.performance_percent = '' THEN 0
          ELSE IFNULL(OTD.performance_percent,0)	
      END AS performance_percent,
      CASE
          WHEN OTD.quality_percent = 'NULL' OR OTD.quality_percent = '' THEN 0
          ELSE IFNULL(OTD.quality_percent,0)	
      END AS quality_percent,
      CASE
          WHEN OTD.scrap_tot_parts = 'NULL' OR OTD.scrap_tot_parts = '' THEN 0
          ELSE IFNULL(OTD.scrap_tot_parts,0)	
      END AS scrap_tot_parts,
      CASE
          WHEN OTD.scrap_tot_def = 'NULL' OR OTD.scrap_tot_def = '' THEN 0
          ELSE IFNULL(OTD.scrap_tot_def,0)	
      END AS scrap_tot_def,
      CASE
          WHEN OTD.dppm_target = 'NULL' OR OTD.dppm_target = '' THEN 0
          ELSE IFNULL(OTD.dppm_target,0)	
      END AS dppm_target,
      CASE
          WHEN OTD.dppm_total_parts = 'NULL' OR OTD.dppm_total_parts = '' THEN 0
          ELSE IFNULL(OTD.dppm_total_parts,0)	
      END AS dppm_total_parts,
      CASE
          WHEN OTD.dppm_total_damaged = 'NULL' OR OTD.dppm_total_damaged = '' THEN 0
          ELSE IFNULL(OTD.dppm_total_damaged,0)	
      END AS dppm_total_damaged,
      CASE
          WHEN OTD.turnover_target = 'NULL' OR OTD.turnover_target = '' THEN 0
          ELSE IFNULL(OTD.turnover_target,0)	
      END AS turnover_target,
      CASE
          WHEN OTD.turnover_staff_beg_month = 'NULL' OR OTD.turnover_staff_beg_month = '' THEN 0
          ELSE IFNULL(OTD.turnover_staff_beg_month,0)	
      END AS turnover_staff_beg_month,
      CASE
          WHEN OTD.turnover_hires_during_month = 'NULL' OR OTD.turnover_hires_during_month = '' THEN 0
          ELSE IFNULL(OTD.turnover_hires_during_month,0)	
      END AS turnover_hires_during_month,
      CASE
          WHEN OTD.turnover_staff = 'NULL' OR OTD.turnover_staff = '' THEN 0
          ELSE IFNULL(OTD.turnover_staff,0)	
      END AS turnover_staff,
      OTD.SNFLK_UPDATEDON AS SrcLastModifiedDate
  FROM 
      CONFORMED.PKG_OTDShipments_History AS OTD
  
  UNION ALL

  SELECT
      IFNULL(OTD.calmondesc,'')			AS calmondesc,
      IFNULL(OTD.calmonth,0)			AS calmonth,
      IFNULL(OTD.calyear,0)				AS calyear,
      IFNULL(OTD.fiscalmonth,0)			AS fiscalmonth,
      IFNULL(OTD.fiscalyear,0)			AS fiscalyear,
      CASE 
          WHEN LEN(OTD.calmonth) = 1 THEN CONCAT(OTD.calyear, '0', OTD.calmonth,'01') 
          ELSE CONCAT(OTD.calyear,OTD.calmonth, '01') 
      END AS PeriodStartDateKey1,
      IFNULL(UPPER(RTRIM(OTD.site )),'')AS SiteName,
      CASE
		  WHEN OTD.otd_Actual = 'NULL' OR  OTD.otd_Actual = '' THEN 0
		  ELSE IFNULL(OTD.otd_Actual,0)
      END AS Otd_Actual,
      CASE
          WHEN OTD.otd_Target = 'NULL' OR OTD.otd_Target = '' THEN 0
          ELSE IFNULL(OTD.otd_Target,0)	
      END AS Otd_Target,
      CASE
          WHEN OTD.util_actual = 'NULL' OR  OTD.util_actual = '' THEN 0
          ELSE IFNULL(OTD.util_actual,0)	
      END AS Util_Actual,
      CASE
          WHEN OTD.util_target = 'NULL' OR OTD.util_target = '' THEN 0
          ELSE IFNULL(OTD.util_target,0)	
      END AS Util_Target,
      CASE
          WHEN OTD.oee_actual = 'NULL' OR OTD.oee_actual = '' THEN 0
          ELSE IFNULL(OTD.oee_actual,0)	
      END AS Oee_Actual,
      CASE
          WHEN OTD.oee_target = 'NULL' OR OTD.oee_target = '' THEN 0
          ELSE IFNULL(OTD.oee_target,0)	
      END AS Oee_Target,
      CASE
          WHEN OTD.scrap_actual = 'NULL' OR OTD.scrap_actual = '' THEN 0
          ELSE IFNULL(OTD.scrap_actual,0)	
      END AS Scrap_Actual,
      CASE
          WHEN OTD.Scrap_Target = 'NULL' OR OTD.Scrap_Target = '' THEN 0
          ELSE IFNULL(OTD.Scrap_Target,0)	
      END AS Scrap_Target,
      CASE
          WHEN OTD.Lss_Actual = 'NULL'  OR OTD.Lss_Actual = ''THEN 0
          ELSE IFNULL(OTD.Lss_Actual,0)	
      END AS Lss_Actual,
      CASE
          WHEN OTD.Lss_Target = 'NULL' OR OTD.Lss_Target = '' THEN 0
          ELSE IFNULL(OTD.Lss_Target,0)	
      END AS Lss_Target,
      CASE
          WHEN OTD.lot_std_valadd_actual = 'NULL' OR OTD.lot_std_valadd_actual = '' THEN 0
          ELSE IFNULL(OTD.lot_std_valadd_actual,0)	
      END AS Lot_Standard,
      CASE
          WHEN OTD.lot_act_valadd_actual = 'NULL' OR OTD.lot_act_valadd_actual = '' THEN 0
          ELSE IFNULL(OTD.lot_act_valadd_actual,0)	
      END AS Lot_Actual,
      CASE
          WHEN OTD.lot_target = 'NULL' OR OTD.lot_target = '' THEN 0
          ELSE IFNULL(OTD.lot_target,0)	
      END AS Lot_Target,
      CASE
          WHEN OTD.total_shipments = 'NULL' OR OTD.total_shipments = '' THEN 0
          ELSE IFNULL(OTD.total_shipments,0)	
      END AS total_shipments,
      CASE
          WHEN OTD.total_late_shipments = 'NULL' OR OTD.total_late_shipments = '' THEN 0
          ELSE IFNULL(OTD.total_late_shipments,0)	
      END AS total_late_shipments,
      CASE
          WHEN OTD.total_available_hours = 'NULL' OR OTD.total_available_hours = '' THEN 0
          ELSE IFNULL(OTD.total_available_hours,0)	
      END AS total_available_hours,
      CASE
          WHEN OTD.total_active_hours = 'NULL' OR OTD.total_active_hours = '' THEN 0
          ELSE IFNULL(OTD.total_active_hours,0)	
      END AS total_active_hours,
      CASE
          WHEN OTD.availability_pecent = 'NULL' OR OTD.availability_pecent = '' THEN 0
          ELSE IFNULL(OTD.availability_pecent,0)	
      END AS availability_pecent,
      CASE
          WHEN OTD.performance_percent = 'NULL'  OR OTD.performance_percent = '' THEN 0
          ELSE IFNULL(OTD.performance_percent,0)	
      END AS performance_percent,
      CASE
          WHEN OTD.quality_percent = 'NULL' OR OTD.quality_percent = '' THEN 0
          ELSE IFNULL(OTD.quality_percent,0)	
      END AS quality_percent,
      CASE
          WHEN OTD.scrap_tot_parts = 'NULL' OR OTD.scrap_tot_parts = '' THEN 0
          ELSE IFNULL(OTD.scrap_tot_parts,0)	
      END AS scrap_tot_parts,
      CASE
          WHEN OTD.scrap_tot_def = 'NULL' OR OTD.scrap_tot_def = '' THEN 0
          ELSE IFNULL(OTD.scrap_tot_def,0)	
      END AS scrap_tot_def,
      CASE
          WHEN OTD.dppm_target = 'NULL' OR OTD.dppm_target = '' THEN 0
          ELSE IFNULL(OTD.dppm_target,0)	
      END AS dppm_target,
      CASE
          WHEN OTD.dppm_total_parts = 'NULL' OR OTD.dppm_total_parts = '' THEN 0
          ELSE IFNULL(OTD.dppm_total_parts,0)	
      END AS dppm_total_parts,
      CASE
          WHEN OTD.dppm_total_damaged = 'NULL' OR OTD.dppm_total_damaged = '' THEN 0
          ELSE IFNULL(OTD.dppm_total_damaged,0)	
      END AS dppm_total_damaged,
      CASE
          WHEN OTD.turnover_target = 'NULL' OR OTD.turnover_target = '' THEN 0
          ELSE IFNULL(OTD.turnover_target,0)	
      END AS turnover_target,
      CASE
          WHEN OTD.turnover_staff_beg_month = 'NULL' OR OTD.turnover_staff_beg_month = '' THEN 0
          ELSE IFNULL(OTD.turnover_staff_beg_month,0)	
      END AS turnover_staff_beg_month,
      CASE
          WHEN OTD.turnover_hires_during_month = 'NULL' OR OTD.turnover_hires_during_month = '' THEN 0
          ELSE IFNULL(OTD.turnover_hires_during_month,0)	
      END AS turnover_hires_during_month,
      CASE
          WHEN OTD.turnover_staff = 'NULL' OR OTD.turnover_staff = '' THEN 0
          ELSE IFNULL(OTD.turnover_staff,0)	
      END AS turnover_staff,
      OTD.SNFLK_UPDATEDON AS SrcLastModifiedDate
  FROM 
      CONFORMED.PKG_OTDShipments AS OTD
) a;