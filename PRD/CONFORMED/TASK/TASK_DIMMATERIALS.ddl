create or replace task TASK_DIMMATERIALS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMPLANTS
	as call conformed.DIMMATERIALS_ADD();