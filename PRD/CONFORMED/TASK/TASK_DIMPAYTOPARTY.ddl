create or replace task TASK_DIMPAYTOPARTY
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMPAYTOPARTY_ADD();