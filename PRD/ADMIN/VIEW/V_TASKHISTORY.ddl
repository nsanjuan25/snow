create or replace view V_TASKHISTORY(
	TABLENAME,
	SOURCEDATA,
	RUNDATE,
	RUNTIMEMINUTES,
	TABLE_NAME,
	NAME,
	QUERY_TEXT,
	CONDITION_TEXT,
	SCHEMA_NAME,
	TASK_SCHEMA_ID,
	DATABASE_NAME,
	TASK_DATABASE_ID,
	SCHEDULED_TIME,
	COMPLETED_TIME,
	STATE,
	RETURN_VALUE,
	QUERY_ID,
	QUERY_START_TIME,
	ERROR_CODE,
	ERROR_MESSAGE,
	GRAPH_VERSION,
	RUN_ID,
	ROOT_TASK_ID
) as
SELECT 
      upper(A.TableName ) as TableName 
    , LEFT( A.TableName , CHARINDEX(  '_', A.TableName , 1 ) - 1 )  as SourceData
    , D.DateKey as RunDate
    , DateDiff( minute, T.Scheduled_Time, T.Completed_Time) as RunTimeMinutes
    , T.TABLE_NAME	
    , T.NAME	
    , T.QUERY_TEXT	
    , T.CONDITION_TEXT	
    , T.SCHEMA_NAME	
    , T.TASK_SCHEMA_ID	
    , T.DATABASE_NAME	
    , T.TASK_DATABASE_ID	
    , T.SCHEDULED_TIME	
    , T.COMPLETED_TIME	
    , IFNULL( T.STATE , 'Missing') AS STATE		
    , T.RETURN_VALUE	
    , T.QUERY_ID	
    , T.QUERY_START_TIME	
    , T.ERROR_CODE	
    , T.ERROR_MESSAGE	
    , T.GRAPH_VERSION	
    , T.RUN_ID	
    , T.ROOT_TASK_ID    
FROM 
    landing.TableMetadata A
    INNER JOIN  Public.DimDates D ON  D.DateKey between DATEADD(Day ,-5, current_date) and DATEADD(DAY,1 , current_date ) 
    
    LEFT OUTER JOIN 
        (
          SELECT 
            SUBSTRING( Name , CHARINDEX(  '_', Name , 1 ) +1  , len ( Name )   ) as Table_Name
            , *            
          FROM 
                SNOWFLAKE.ACCOUNT_USAGE.TASK_HISTORY T1 
                inner join public.dimdates d1 on cast( T1.Scheduled_time as date) = d1.Datekey
          WHERE 
                d1.datekey   between DATEADD(Day ,-5, current_date) and DATEADD(DAY,1 , current_date ) 
        ) T ON upper(A.TableName) = T.Table_name
        and D.DateKey = Cast( T.Scheduled_time as date)
        AND T.DATABASE_NAME = CURRENT_DATABASE();