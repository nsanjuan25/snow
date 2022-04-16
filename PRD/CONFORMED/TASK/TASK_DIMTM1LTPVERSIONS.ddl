create or replace task TASK_DIMTM1LTPVERSIONS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMETRICDETAILS
	as call conformed.DimTM1LTPVersions_Add();