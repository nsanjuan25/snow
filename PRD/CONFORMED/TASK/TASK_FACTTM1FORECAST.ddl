create or replace task TASK_FACTTM1FORECAST
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMTM1PROFITCENTERXREF
	as call conformed.FACTTM1FORECAST_Add();