create or replace view V_TM1_METRICS(
	METRIC,
	PARENT,
	ACCOUNT,
	PERIODSTARTDATEKEY,
	QTRMONTHSTARTDATEKEY,
	QTRMONTHENDDATEKEY,
	PERIODSTART90DAYSBACK,
	PRIORMONTHKEY,
	VERSION,
	TWELVEMONTHSTARTDATEKEY,
	STARTMONTHKEY,
	ENDMONTHKEY
) as
SELECT 
    M.Metric,
    M.Parent,
    M.Account,
    D.PeriodStartDateKey,
    D.QtrMonthStartDateKey,
    D.QtrMonthEndDateKey,
    D.PeriodStart90DaysBack,
    D.PriorMonthKey,
    M.Version,
    TwelveMonthStartDateKey,
    CASE
       WHEN StartMonth = 'QtrStart' THEN D.QtrMonthStartDateKey
       WHEN StartMonth = '90DaysBack' THEN D.PeriodStart90DaysBack
       WHEN StartMonth = 'QtrEnd' THEN D.QtrMonthEndDateKey
       WHEN StartMonth = 'PriorMonth' THEN D.PriorMonthKey
       WHEN StartMonth = 'FiscalYear' THEN to_date (cast ( D.FiscalYearStartDateKey as char(8)) , 'yyyymmdd')
       ELSE D.PeriodStartDateKey
    END StartMonthKey,
     CASE
       WHEN EndMonth = 'QtrEnd' THEN D.QtrMonthEndDateKey
       WHEN EndMonth = '90DaysBack' THEN D.PeriodStart90DaysBack
       WHEN EndMonth = 'PriorMonth' THEN D.PriorMonthKey
       WHEN EndMonth LIKE '%+%' THEN add_months ( d.datekey , cast(right(m.endmonth , 1) as int))
       WHEN EndMonth = 'FiscalYear' THEN to_date (cast ( D.FiscalYearEndDateKey as char(8)) , 'yyyymmdd')
       WHEN EndMonth = '12Months' THEN D.TwelveMonthStartDateKey
       ELSE D.PeriodStartDateKey
    END EndMonthKey
FROM TM1.DimTM1Metrics M
    CROSS JOIN conformed.v_dates_tm1 D;