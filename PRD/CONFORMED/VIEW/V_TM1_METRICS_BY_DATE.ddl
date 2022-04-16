create or replace view V_TM1_METRICS_BY_DATE(
	SNAPSHOTDATEKEY,
	WEEKSTARTDATEKEY,
	METRIC,
	ACCOUNT,
	PARENT,
	VERSION,
	PERIODSTARTDATEKEY,
	STARTMONTHKEY,
	ENDMONTHKEY
) as
 
 SELECT
    SD.SnapshotDateKey
    , SD.WeekStartDateKey
    , M0.Metric
    , M0.Account
    , M0.Parent
    , M0.Version
    , M0.PeriodStartDateKey
    , M0.StartMonthKey
    , M0.EndMonthKey
FROM 
    conformed.v_TM1_Metrics M0
    INNER JOIN  
   ( SELECT
            F.SnapshotDateKey
            , SD.WeekStartDateKey
            , CASE WHEN F.Version='8 Quarter' THEN F.Version ELSE 'Locked Forecast' END Version
            , MIN(ForecastStartDateKey) ForecastStartDateKey
        FROM
           TM1.FactForecast F
            INNER JOIN (

                  SELECT
                    SD.WeekStartDateKey
                    , F.Version
                    , MAX(SnapshotDateKey) AS SnapshotDateKey
                FROM
                    TM1.FactForecast F
                    INNER JOIN Public.DimDates SD ON F.SnapshotDateKey=SD.DateKey
                WHERE
                    F.Version='8 Quarter'
                    OR F.Version LIKE '%Locked Forecast'
                GROUP BY
                    SD.WeekStartDateKey
                    , F.Version) SD ON 
                F.SnapshotDateKey=SD.SnapshotDateKey
                AND F.Version=SD.Version
        GROUP BY
            F.SnapshotDateKey
            , SD.WeekStartDateKey
            , CASE WHEN F.Version='8 Quarter' THEN F.Version ELSE 'Locked Forecast' END       
            ) SD ON
        M0.PeriodStartDateKey=SD.ForecastStartDateKey
        AND M0.Version=SD.Version;