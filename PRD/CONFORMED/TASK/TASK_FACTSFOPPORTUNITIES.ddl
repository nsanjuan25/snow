create or replace task TASK_FACTSFOPPORTUNITIES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMSFSETTARGETPLANTS
	as call conformed.FactSFOpportunities_Add();