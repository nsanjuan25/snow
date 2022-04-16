create or replace task TASK_FACTPURCHASEORDERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMAML
	as call conformed.FactPurchaseOrders_ADD();