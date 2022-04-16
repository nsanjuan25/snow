create or replace task TASK_START_TMS_SCHEDULE1
	warehouse=WH_TASKS
	schedule='USING CRON 35 02 * * * America/New_York'
	COMMENT='Tasks for TMS SCHDULE 1'
	as SELECT 'Log Start Process';