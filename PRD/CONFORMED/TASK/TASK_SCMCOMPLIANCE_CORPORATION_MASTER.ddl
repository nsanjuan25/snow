create or replace task TASK_SCMCOMPLIANCE_CORPORATION_MASTER
	warehouse=WH_TASKS
	schedule='USING CRON 1 7 * * * America/New_York'
	when SYSTEM$STREAM_HAS_DATA('Landing.stm_SCMCompliance_CORPORATION_MASTER')
	as call Landing.TABLE_LOAD_FULL_ADD('SCMCompliance_CORPORATION_MASTER', 'YES');