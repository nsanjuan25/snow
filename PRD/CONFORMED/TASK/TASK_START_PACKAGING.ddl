create or replace task TASK_START_PACKAGING
	warehouse=WH_TASKS
	schedule='USING CRON 45 16 * * * America/New_York'
	COMMENT='Log Start Process Packaging'
	as SELECT 'Log Start Process';