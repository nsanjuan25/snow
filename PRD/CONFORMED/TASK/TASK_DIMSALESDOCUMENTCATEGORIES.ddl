create or replace task TASK_DIMSALESDOCUMENTCATEGORIES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMCUSTOMERORDERTYPES
	as CALL CONFORMED.DIMSALESDOCUMENTCATEGORIES_ADD();