create or replace view V_FACTFORECAST_DEBUG(
	SNAPSHOTDATEKEY,
	DATEKEY,
	FORECASTSTARTDATEKEY,
	PERIODSTARTDATEKEY,
	PERIOD,
	PROFITCENTERCODE,
	COSTCENTERCODE,
	ACCOUNT,
	VERSION,
	CURRENCY,
	CURRENCYTYPE,
	M_GL,
	VALUE,
	COMMENTS
) as

Select 
         tm1.exportdate as SnapshotDateKey
       , da.datekey
	   , A.ForecastStartDateKey
	   , try_to_date ( TM1.Period || '-01' , 'mmmm-yy-dd') as Periodstartdatekey
	   , TM1.Period as Period
	   , COALESCE ( X.ProfitCenterCode , CASE 
         WHEN RIGHT(TM1.ProfitCenter,1)='_' THEN LEFT(TM1.ProfitCenter,LEN(TM1.ProfitCenter)-1) 
         ELSE TM1.ProfitCenter 
         END ) AS ProfitCenterCode
       , COALESCE ( CX.CostCentercode , CASE 
         WHEN RIGHT(TM1.CostCenter,1)='_' THEN LEFT(TM1.CostCenter,LEN(TM1.CostCenter)-1) 
         ELSE TM1.CostCenter 
         END ) AS CostCenterCode		
	   , COALESCE (AX.ToAccount, TM1.Account) as Account
	   , TM1.Version
	   , TM1.Currency
	   , TM1.CurrencyType
	   , TM1.M_GL
       , CASE 
           WHEN TM1.M_GL = 'Comments' THEN cast ( 0  as double)
           ELSE  ( case when value = '.' then cast (0 as double)
                    else case when try_to_numeric(value) is null then null 
                     else value end  end ) 
        END Value 
       , CASE 
           WHEN TM1.M_GL = 'Comments' THEN TM1.Value 
           ELSE NULL 
        END Comments 
FROM
    conformed.TM1_RPGL_IMDB TM1
    INNER JOIN Public.Dimdates DA
        on tm1.exportdate = DA.datekey
    INNER JOIN 
      ( 
              SELECT 
                  ExportDate 
                  , Version 
                  , MIN(try_to_date ( TM1.Period || '-01' , 'mmmm-yy-dd')) as ForecastStartDateKey
                  , max(FRMW_EXTRACTED_ON) as LastUpdated
              FROM
                  conformed.TM1_RPGL_IMDB TM1
              GROUP BY
                    ExportDate 
                  , Version 
       )A 
     ON TM1.ExportDate=A.ExportDate
        AND TM1.Version=A.Version
        AND TM1.FRMW_EXTRACTED_ON = A.LastUpdated 

    LEFT JOIN tm1.DimTM1profitcenterxref X ON 
        CASE 
            WHEN RIGHT(TM1.ProfitCenter,1)='_' THEN LEFT(TM1.ProfitCenter,LEN(TM1.ProfitCenter)-1) 
            ELSE TM1.ProfitCenter 
        END=X.TM1ProfitCenterCode
    LEFT JOIN tm1.DimTM1costcenterxref CX ON
        CASE 
                WHEN RIGHT(TM1.CostCenter,1)='_' THEN LEFT(TM1.CostCenter,LEN(TM1.CostCenter)-1) 
                ELSE TM1.CostCenter 
        END=CX.tm1CostCenterCode
    LEFT JOIN tm1.DimTM1Accountxref AX ON
        TM1.Account=AX.FromAccount;