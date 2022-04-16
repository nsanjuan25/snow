create or replace task TASK_DIMAML
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMMATERIALS
	as call conformed.DIMAML_ADD();