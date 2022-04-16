create or replace task TASK_FACTPURCHASESCHEDULES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMAML
	as call conformed.FactPurchaseSchedules_ADD();