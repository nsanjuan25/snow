create or replace task TASK_FACTMATERIALSELLPRICEHISTORY
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.FactMaterialSellPriceHistory_ADD();