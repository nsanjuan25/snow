create or replace task TASK_START_ORDERS
	warehouse=WH_TASKS
	schedule='USING CRON 15 08 * * * America/New_York'
	COMMENT='Log Start Process SAP_ORDERS'
	as SELECT 'Log Start Process';