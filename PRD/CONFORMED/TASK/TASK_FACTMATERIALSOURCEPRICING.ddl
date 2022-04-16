create or replace task TASK_FACTMATERIALSOURCEPRICING
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.FactMaterialSourcePricing_ADD();