create or replace task TASK_DIMIHSLIFECYCLE
	warehouse=WH_TASKS
	USER_TASK_TIMEOUT_MS=43200000
	after PRD.CONFORMED.TASK_IHS_LIFECYCLE_LANDING_ADD
	as CALL CONFORMED.DIMIHSLIFECYCLE_ADD();