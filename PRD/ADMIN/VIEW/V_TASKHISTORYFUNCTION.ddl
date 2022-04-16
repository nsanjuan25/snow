create or replace view V_TASKHISTORYFUNCTION(
	TABLENAME,
	SOURCEDATA,
	RUNTIMEMINUTES,
	RUNDATE,
	TABLE_NAME,
	QUERY_ID,
	NAME,
	DATABASE_NAME,
	SCHEMA_NAME,
	QUERY_TEXT,
	CONDITION_TEXT,
	STATE,
	ERROR_CODE,
	ERROR_MESSAGE,
	SCHEDULED_TIME,
	QUERY_START_TIME,
	NEXT_SCHEDULED_TIME,
	COMPLETED_TIME,
	ROOT_TASK_ID,
	GRAPH_VERSION,
	RUN_ID,
	RETURN_VALUE
) as 
    SELECT 
           upper(TM.TableName ) AS TableName
         , LEFT( TableName , CHARINDEX(  '_', TableName , 1 ) - 1 )  as SourceData
         , DateDiff( minute, tab.Scheduled_Time, tab.Completed_Time) as RunTimeMinutes
         , tab.RUNDATE	
         , tab.TABLE_NAME	
         , tab.QUERY_ID	
         , tab.NAME	
         , tab.DATABASE_NAME	
         , tab.SCHEMA_NAME	
         , tab.QUERY_TEXT	
         , tab.CONDITION_TEXT	
         , tab.STATE
         , tab.ERROR_CODE	
         , tab.ERROR_MESSAGE	
         , tab.SCHEDULED_TIME	
         , tab.QUERY_START_TIME	
         , tab.NEXT_SCHEDULED_TIME	
         , tab.COMPLETED_TIME	
         , tab.ROOT_TASK_ID	
         , tab.GRAPH_VERSION	
         , tab.RUN_ID	
         , tab.RETURN_VALUE
    FROM
        landing.TableMetadata TM 
        LEFT OUTER JOIN 
        ( 
            SELECT 
                CAST( Scheduled_time as Date ) RunDate      
                , SUBSTRING( Name , CHARINDEX(  '_', Name , 1 ) +1  , len ( Name )   ) as Table_Name
                , * 
            FROM
              table(information_schema.task_history (
                      scheduled_time_range_start=>dateadd('hour',-12,current_timestamp())
                      , scheduled_time_range_end=>dateadd('hour',4,current_timestamp())
                      , result_limit => 10000 )) a            
     ) tab ON tm.TableName = tab.Table_Name 
     AND DATABASE_NAME = CURRENT_DATABASE();