create or replace task TASK_FACTSATQUOTE
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMRP
	as call conformed.FactSATQuotes_ADD();