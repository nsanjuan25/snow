create or replace task TASK_TMS_TRACKING_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call TMS_FactTracking_Add ('tms_Tracking');