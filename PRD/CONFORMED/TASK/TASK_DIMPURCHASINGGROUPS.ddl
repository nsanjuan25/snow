create or replace task TASK_DIMPURCHASINGGROUPS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMPURCHASINGGROUPS_ADD();