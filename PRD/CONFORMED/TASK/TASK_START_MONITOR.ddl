create or replace task TASK_START_MONITOR
	warehouse=WH_TASKS
	schedule='USING CRON 30 12 * * * America/New_York'
	as call TASK_MONITOR();