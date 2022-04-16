create or replace task TASK_TMS_TRACKING_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_Tracking')
	as call TMS_FactTracking_Add ('tms_Tracking');