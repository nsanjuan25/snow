create or replace task TASK_DIMTM1ACCOUNTFLAT
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_FOOTPRINT
	as call conformed.DimTM1Accountflat_Add();