create or replace task TASK_FACTMETRICDETAILS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTTM1ACTUALS
	as call conformed.FactMetricDetails_Add();