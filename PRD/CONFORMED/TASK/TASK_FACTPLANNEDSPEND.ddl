create or replace task TASK_FACTPLANNEDSPEND
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMRP
	as call conformed.FactPlannedSpend_ADD();