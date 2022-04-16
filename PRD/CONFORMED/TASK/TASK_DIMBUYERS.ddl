create or replace task TASK_DIMBUYERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMMATERIALGROUPS
	as call conformed.DIMBUYERS_ADD();