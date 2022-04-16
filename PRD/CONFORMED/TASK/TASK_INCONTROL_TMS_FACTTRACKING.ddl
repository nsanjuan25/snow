create or replace task TASK_INCONTROL_TMS_FACTTRACKING
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_TRACKING_S1
	as call  InControl_TMS_FactTracking();