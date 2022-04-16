create or replace task TASK_DIMSFACCOUNTS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_FOOTPRINT
	as call conformed.DIMSFAccounts_Add();