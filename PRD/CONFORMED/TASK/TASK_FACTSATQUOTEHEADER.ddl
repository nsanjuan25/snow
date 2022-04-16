create or replace task TASK_FACTSATQUOTEHEADER
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMRP
	as call Conformed.FactSATQuoteHeader_ADD();