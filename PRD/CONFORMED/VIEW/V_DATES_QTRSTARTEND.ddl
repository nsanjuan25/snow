create or replace view V_DATES_QTRSTARTEND(
	FISCALQUARTER,
	QTRMONTHSTARTDATEKEY,
	QTRMONTHENDDATEKEY,
	QTRENDDATEKEY
) as
SELECT FiscalQuarter, 
       min(StartMonthDateKey) QtrMonthStartDateKey, 
       max(StartMonthDateKey) QtrMonthEndDateKey, 
       max(DateKey) QtrEndDateKey 
FROM public.dimdates 
GROUP BY FiscalQuarter;