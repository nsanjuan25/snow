create or replace task TASK_FACTMATERIALSOURCE
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.FactMaterialSource_ADD();