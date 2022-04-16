create or replace task TASK_START_FACTSFPROJECTREQUESTS
	warehouse=WH_TASKS
	schedule='120 MINUTE'
	TIMEZONE='America/New_York'
	COMMENT='Log Start Process SF ProjectRequests - Note: this task should be resume at exactly EVEN Hours, ex. 08 AM, 10 AM...so on'
	as SELECT 'Log Start Process';