create or replace task TASK_DIMTM1MGLFLAT
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMTM1ACCOUNTFLAT
	as call conformed.DimTM1MGLflat_Add();