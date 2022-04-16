create or replace view V_TASK_HISTORY_SCHEMA(
	FULLY_QUALIFIED_NAME,
	LAST_RUN_STATE,
	ERROR_MESSAGE,
	SCHEDULED_TIME,
	COMPLETED_TIME,
	NEXT_SCHEDULED_TIME,
	QUERY_TEXT,
	RN,
	DURATION,
	QUERY_ID,
	CONDITION_TEXT,
	ERROR_CODE
) COMMENT='Get Task History from function information_schema.task_history'
 as
SELECT 
           concat(database_name,'.',schema_name,'.',name) AS fully_qualified_name
         , t1.state last_run_state
         , t1.error_message
         , t1.scheduled_time
         , t1.completed_time
         , t1.next_scheduled_time
         , t1.query_text
         , row_number() over(partition BY t1.name ORDER BY t1.scheduled_time DESC) rn //row number just to get the most recent run of this task
         , cast(TIMESTAMPDIFF(t1.second, t1.scheduled_time, t1.completed_time)/60 AS number(10,2)) duration
         , t1.Query_ID
         , t1.condition_text
         , t1.error_code
  FROM 
        table(information_schema.task_history()) t1 //Going back this far in case we have tasks that run frequently.;
;