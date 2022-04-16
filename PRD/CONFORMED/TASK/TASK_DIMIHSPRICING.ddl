create or replace task TASK_DIMIHSPRICING
	warehouse=WH_TASKS
	schedule='USING CRON 30 2 * * * America/New_York'
	USER_TASK_TIMEOUT_MS=43200000
	when SYSTEM$STREAM_HAS_DATA('CONFORMED.STM_IHS_PRICING')
	as CALL CONFORMED.DIMIHSPRICING_ADD();