create or replace task TASK_FACTMATERIALSOURCEINFORMATION
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMAML
	as call conformed.FactMaterialSourceInformation_ADD();