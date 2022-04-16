create or replace task TASK_DIMSAPFUNCTIONS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMSAPUSERS
	as call conformed.DIMSAPFUNCTIONS_ADD();