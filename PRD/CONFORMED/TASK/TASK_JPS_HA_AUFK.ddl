create or replace task TASK_JPS_HA_AUFK
	warehouse=WH_TASKS
	schedule='USING CRON 15 08 * * * UTC'
	when SYSTEM$STREAM_HAS_DATA('LANDING.STM_JPS_HA_AUFK')
	as CALL LANDING.TABLE_LOAD_FULL_ADD('JPS_HA_AUFK', 'NO');