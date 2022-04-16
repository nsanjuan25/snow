create or replace task TASK_FACTSATQUOTESITEPARTSOURCESPLIT
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMRP
	as call PRD.conformed.FactSATQuoteSitePartSourceSplit_ADD();