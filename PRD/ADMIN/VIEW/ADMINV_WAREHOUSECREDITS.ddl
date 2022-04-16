create or replace view ADMINV_WAREHOUSECREDITS(
	WAREHOUSE_NAME,
	START_TIME,
	CREDITS_USED
) COMMENT='This view provides credits usage by Warehouse/Snowpipe'
 as
/*
This is a test
*/
    SELECT 
          Warehouse_Name
        , Start_Time
        , Credits_Used
    FROM 
        snowflake.account_usage.Warehouse_Metering_History 
                        
    UNION ALL

    SELECT 
         'Snowpipe' as WareHouse_Name
        , Start_Time 
        , Sum(Credits_Used) as Credits_Used

    FROM 
        snowflake.account_usage.PIPE_USAGE_HISTORY puh
    GROUP BY
        Start_Time;