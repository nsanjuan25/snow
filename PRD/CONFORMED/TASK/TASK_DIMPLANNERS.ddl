create or replace task TASK_DIMPLANNERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMBUYERS
	as call conformed.DIMPLANNERS_ADD();