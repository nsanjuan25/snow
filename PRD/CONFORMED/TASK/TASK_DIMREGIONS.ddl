create or replace task TASK_DIMREGIONS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMREGIONS_ADD();