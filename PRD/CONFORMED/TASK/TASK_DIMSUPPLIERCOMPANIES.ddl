create or replace task TASK_DIMSUPPLIERCOMPANIES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMSUPPLIERCOMPANIES_ADD();