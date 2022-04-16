create or replace task TASK_START_FOOTPRINT
	warehouse=WH_TASKS
	schedule='USING CRON 30 10 * * * America/New_York'
	as SELECT 'Log Start Process';