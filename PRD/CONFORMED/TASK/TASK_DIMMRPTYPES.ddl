create or replace task TASK_DIMMRPTYPES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMMRPTYPES_ADD();