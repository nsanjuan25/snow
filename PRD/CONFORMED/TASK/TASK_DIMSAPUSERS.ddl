create or replace task TASK_DIMSAPUSERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_SAPUSAGE
	as call conformed.DIMSAPUSERS_ADD();