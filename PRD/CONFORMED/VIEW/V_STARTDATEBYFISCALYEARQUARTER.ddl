create or replace view V_STARTDATEBYFISCALYEARQUARTER(
	DATEKEY,
	FISCALYEAR,
	FISCALQUARTERNUMBER,
	FISCALQUARTER,
	FISCALQUARTERPERIOD
) as
SELECT 
      MIN ( DateKey  ) AS DateKey
    , DD.FiscalYear
    , DD.FiscalQuarterNumber
    , DD.FiscalQuarter
    , 'Q' || DD.FiscalQuarterNumber || ' ' ||  DD.FiscalYear as FiscalQuarterPeriod
FROM
    public.DimDates AS DD
GROUP BY         
      DD.FiscalYear
    , DD.FiscalQuarterNumber
    , DD.FiscalQuarter;