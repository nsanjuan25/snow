create or replace task TASK_DIMSELLERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMSELLERS_ADD();