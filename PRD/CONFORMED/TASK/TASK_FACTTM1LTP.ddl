create or replace task TASK_FACTTM1LTP
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMTM1LTPVERSIONS
	as call conformed.FactTM1LTP_Add();