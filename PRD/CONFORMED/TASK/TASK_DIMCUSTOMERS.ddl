create or replace task TASK_DIMCUSTOMERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMCUSTOMERS_ADD();