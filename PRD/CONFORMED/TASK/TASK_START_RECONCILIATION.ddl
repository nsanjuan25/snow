create or replace task TASK_START_RECONCILIATION
	warehouse=WH_TASKS
	schedule='USING CRON 0 16 * * * America/New_York'
	COMMENT='Log Start Process Reconciliation'
	as SELECT 'Log Start Process';