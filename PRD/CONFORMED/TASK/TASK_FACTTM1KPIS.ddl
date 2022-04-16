create or replace task TASK_FACTTM1KPIS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_FACTMETRICDETAILS
	as call conformed.FACTTM1KPIS_ADD();