create or replace task TASK_START_SAPUSAGE
	warehouse=WH_TASKS
	schedule='USING CRON 53 14 * * * America/New_York'
	as SELECT 'Log Start Process';