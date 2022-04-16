create or replace task TASK_DIMCAMPUS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMREGIONS
	as call conformed.DIMCAMPUS_ADD();