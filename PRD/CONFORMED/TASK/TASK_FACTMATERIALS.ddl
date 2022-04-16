create or replace task TASK_FACTMATERIALS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMRP
	as call FactMaterials_ADD();