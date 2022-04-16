create or replace view V_DATES_TM1(
	PERIODSTARTDATEKEY,
	QTRMONTHSTARTDATEKEY,
	QTRMONTHENDDATEKEY,
	PERIODSTART90DAYSBACK,
	PRIORMONTHKEY,
	FISCALYEARSTARTDATEKEY,
	FISCALYEARENDDATEKEY,
	DATEKEY,
	TWELVEMONTHDATEKEY,
	TWELVEMONTHSTARTDATEKEY
) as
SELECT DISTINCT
    D.StartMonthDateKey as  PeriodStartDateKey,
    QD.QtrMonthStartDateKey,
    QD.QtrMonthEndDateKey,
    DD.StartMonthDateKey as PeriodStart90DaysBack,
    PM.StartMonthDateKey as PriorMonthKey,
    (D.FiscalYear-1) * 10000 + 901 as FiscalYearStartDateKey,
    (D.FiscalYear) * 10000 + 801 as FiscalYearEndDateKey,
    D.Datekey,
    YM.DateKey TwelveMonthDateKey,
    YM.StartMonthDateKey TwelveMonthStartDateKey
FROM 
	public.DimDates d
	INNER JOIN conformed.v_dates_qtrstartend qd ON D.FiscalQuarter = QD.FiscalQuarter
	INNER JOIN public.DimDates dd ON add_months(D.Datekey, -2) = DD.Datekey
	INNER JOIN public.DimDates pm ON add_months(D.Datekey, -1) = PM.Datekey
	INNER JOIN public.DimDates YM ON add_months(D.Datekey, 11) = YM.Datekey
WHERE 
    D.DateKey=D.StartMonthDateKey;