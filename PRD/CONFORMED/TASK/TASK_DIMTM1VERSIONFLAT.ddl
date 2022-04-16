create or replace task TASK_DIMTM1VERSIONFLAT
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMTM1PERIODFLAT
	as call conformed.DimTM1Versionflat_Add();