create or replace task TASK_DIMSFSETTARGETPLANTS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMSFACCOUNTS
	as call conformed.DIMSFSetTargetPlants_Add();