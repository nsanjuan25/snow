create or replace task TASK_DIMPLANTS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMPLANNERS
	as call conformed.DIMPLANTS_ADD();