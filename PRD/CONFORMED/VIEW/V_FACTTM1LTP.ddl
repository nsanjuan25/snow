create or replace view V_FACTTM1LTP(
	SNAPSHOTDATEID,
	LTPVERSIONKEY,
	PERIODSTARTDATEKEY,
	LTPACCOUNT,
	LTPCUSTOMER,
	VALUE,
	FRMW_EXTRACTED_ON
) as
select  distinct 
         cast  ( I.frmw_extracted_on as date) as SnapShotDateID
        ,DV.LTPVersionkey
        ,D.PeriodStartDateKey
        ,upper ( TRIM( I.ltpaccount ) ) as ltpaccount
        ,upper ( TRIM( I.ltpcustomer) ) as ltpcustomer
        ,I.value
		,I.frmw_extracted_on
    from conformed.TM1_LTP_CustomerData I
    inner join 
    tm1.DimTM1LTPVersions dv
    on Upper(I.ltpversion) = Upper(DV.LTPVersion)
    left outer join 
    (  select 
        'FY ' || FISCALYEAR AS FYPeriod
        ,MIN ( DATEKEY) AS PeriodStartDateKey
        from public.dimdates
        GROUP BY FISCALYEAR
     ) D
     on i.ltpperiod = d.FYPeriod
     where I.value is not null	
;