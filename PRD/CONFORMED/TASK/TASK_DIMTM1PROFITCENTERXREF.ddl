create or replace task TASK_DIMTM1PROFITCENTERXREF
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMTM1COSTCENTERXREF
	as call conformed.DimTM1profitcenterxref_Add();