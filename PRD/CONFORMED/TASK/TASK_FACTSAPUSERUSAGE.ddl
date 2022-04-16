create or replace task TASK_FACTSAPUSERUSAGE
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTGRC
	as call conformed.FACTSAPUSERUSAGE_ADD();