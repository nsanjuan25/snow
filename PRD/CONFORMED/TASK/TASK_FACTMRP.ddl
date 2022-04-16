create or replace task TASK_FACTMRP
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTPURCHASEORDERS
	as call conformed.FactMRP_ADD();