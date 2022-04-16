create or replace task TASK_START_SALESORDERS
	warehouse=WH_TASKS
	schedule='USING CRON 30 08 * * * America/New_York'
	COMMENT='Log Start Process SAP_SALESORDERS'
	as SELECT 'Log Start Process';