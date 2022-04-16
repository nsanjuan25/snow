create or replace task TASK_FACTACCOUNTSRECEIVABLE
	warehouse=WH_TASKS
	schedule='USING CRON 0 17 * * * America/New_York'
	as call CONFORMED.FACTACCOUNTSRECEIVABLE_ADD();