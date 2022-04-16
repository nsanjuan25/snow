create or replace task TASK_COUPA_MISSINGID_UNLOAD
	warehouse=WH_TASKS
	schedule='USING CRON 0 03 * * * UTC'
	as CALL COUPA_MISSINGID_UNLOAD();