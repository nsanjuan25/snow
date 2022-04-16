create or replace task TASK_FACTTM1ACTUALS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTTM1FORECAST
	as call conformed.FACTTM1ACTUALS_Add();