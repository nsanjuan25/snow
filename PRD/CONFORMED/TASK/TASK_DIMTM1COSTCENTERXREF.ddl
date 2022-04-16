create or replace task TASK_DIMTM1COSTCENTERXREF
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMTM1VERSIONFLAT
	as call conformed.DimTM1costcenterxref_Add();