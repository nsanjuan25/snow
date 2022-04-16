create or replace task TASK_SCMCOMPLIANCE_COMMODITIES
	warehouse=WH_TASKS
	schedule='USING CRON 1 7 * * * America/New_York'
	when SYSTEM$STREAM_HAS_DATA('Landing.stm_SCMCompliance_Commodities')
	as call Landing.TABLE_LOAD_FULL_ADD('SCMCompliance_Commodities', 'YES');