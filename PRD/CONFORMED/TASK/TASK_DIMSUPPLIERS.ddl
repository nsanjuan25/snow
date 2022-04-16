create or replace task TASK_DIMSUPPLIERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMSUPPLIERS_ADD();