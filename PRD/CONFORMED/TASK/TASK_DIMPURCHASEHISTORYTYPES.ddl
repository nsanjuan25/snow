create or replace task TASK_DIMPURCHASEHISTORYTYPES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMPURCHASEHISTORYTYPES_ADD();