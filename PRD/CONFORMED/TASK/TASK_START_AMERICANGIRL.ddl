create or replace task TASK_START_AMERICANGIRL
	warehouse=WH_TASKS
	schedule='USING CRON 0 10 * * * America/New_York'
	COMMENT='Tasks for American Girl to Unload data in Trusted bucket, daily every 10AM EST'
	as SELECT 'Log Start Process';