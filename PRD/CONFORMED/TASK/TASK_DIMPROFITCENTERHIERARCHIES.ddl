create or replace task TASK_DIMPROFITCENTERHIERARCHIES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMPROFITCENTERHIERARCHIES_ADD();