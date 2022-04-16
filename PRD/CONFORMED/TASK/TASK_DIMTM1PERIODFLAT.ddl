create or replace task TASK_DIMTM1PERIODFLAT
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMTM1MGLFLAT
	as call conformed.DimTM1PeriodFlat_Add();