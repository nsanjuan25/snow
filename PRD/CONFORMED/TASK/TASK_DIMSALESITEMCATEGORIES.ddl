create or replace task TASK_DIMSALESITEMCATEGORIES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMSALESDOCUMENTCATEGORIES
	as CALL CONFORMED.DIMSALESITEMCATEGORIES_ADD();