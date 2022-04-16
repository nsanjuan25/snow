create or replace task TASK_FACTPURCHASEHISTORY
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMAML
	as call conformed.FactPurchaseHistory_ADD();