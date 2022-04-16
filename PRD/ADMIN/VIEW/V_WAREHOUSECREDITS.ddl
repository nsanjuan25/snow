create or replace view V_WAREHOUSECREDITS(
	WAREHOUSE_NAME,
	START_TIME,
	CREDITS_USED
) COMMENT='This view provides credits usage by Warehouse/Snowpipe'
 as
    SELECT 
          Warehouse_Name
        , Start_Time
        , Credits_Used
    FROM 
        snowflake.account_usage.Warehouse_Metering_History 
                        
    UNION ALL

    SELECT 
         'SNOWPIPE' as WareHouse_Name
        , Start_Time 
        , Sum(Credits_Used) as Credits_Used

    FROM 
        snowflake.account_usage.PIPE_USAGE_HISTORY puh
    GROUP BY
        Start_Time
        
    UNION ALL         

    SELECT 
        'SERVERLESS_TASKS'
      , start_time
      , SUM(credits_used) AS Credits_Used
    FROM
        snowflake.account_usage.serverless_task_history
    GROUP BY 
        start_time
    
    UNION ALL
    
    SELECT
          'MATERIALIZED VIEWS'
        , start_time
        , SUM(credits_used) AS Credits_Used
    FROM 
        SNOWFLAKE.ACCOUNT_USAGE.MATERIALIZED_VIEW_REFRESH_HISTORY
    GROUP BY
        START_TIME 
        
    UNION ALL 
    
    SELECT  
        'AUTOMATIC_CLUSTERING'
        , start_time
        , SUM(credits_used) AS Credits_Used
    FROM 
        SNOWFLAKE.ACCOUNT_USAGE.AUTOMATIC_CLUSTERING_HISTORY
    GROUP BY 
        START_TIME ;