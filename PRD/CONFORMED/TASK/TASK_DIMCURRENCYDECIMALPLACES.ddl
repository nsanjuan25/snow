create or replace task TASK_DIMCURRENCYDECIMALPLACES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMCURRENCYDECIMALPLACES_ADD();