create or replace task TASK_FACTHISTORICALSPEND
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMOVEMENTS
	as call conformed.FactHistoricalSpend_ADD();