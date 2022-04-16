create or replace task TASK_FACTTM1LTPSPACE
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTTM1LTP
	as call conformed.FactTM1LTPSpace_Add();