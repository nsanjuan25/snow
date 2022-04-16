create or replace task TASK_IHS_LIFECYCLE_LANDING_ADD
	warehouse=WH_TASKS
	USER_TASK_TIMEOUT_MS=43200000
	after PRD.CONFORMED.TASK_DIMIHSPRICING
	when SYSTEM$STREAM_HAS_DATA('CONFORMED.STM_IHS_LIFECYCLE')
	as CALL CONFORMED.IHS_LIFECYCLE_LANDING_ADD();