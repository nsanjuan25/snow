create or replace task TASK_START_TMS_SCHEDULE2
	warehouse=WH_TASKS
	schedule='USING CRON 35 14 * * * America/New_York'
	COMMENT='Tasks for TMS SCHDULE 2'
	as SELECT 'Log Start Process';