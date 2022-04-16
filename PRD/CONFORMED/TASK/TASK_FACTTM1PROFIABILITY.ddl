create or replace task TASK_FACTTM1PROFIABILITY
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTTM1LTPSPACE
	as call conformed.FactTM1Profiability_Add();