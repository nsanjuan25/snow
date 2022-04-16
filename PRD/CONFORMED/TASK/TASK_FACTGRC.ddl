create or replace task TASK_FACTGRC
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMSAPTRANSACTIONCODES
	as call conformed.FACTGRC_ADD();