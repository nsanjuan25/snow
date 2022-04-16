create or replace task TASK_DIMIHSUPSUCSPERIPHERALICS
	warehouse=WH_TASKS
	schedule='USING CRON 0 21 * * * America/New_York'
	USER_TASK_TIMEOUT_MS=43200000
	when SYSTEM$STREAM_HAS_DATA('CONFORMED.STM_IHS_UPS_UCS_PERIPHERAL_ICS')
	as CALL CONFORMED.DIMIHSUPSUCSPERIPHERALICS_ADD();