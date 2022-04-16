create or replace task TASK_FACTMATERIALSTANDARDPRICEHISTORY
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMAML
	as call conformed.FactMaterialStandardPriceHistory_ADD();