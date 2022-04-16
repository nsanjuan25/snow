create or replace task TASK_TMS_ACTIVITIES_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call Conformed.TMS_FactActivities_Add ('tms_Activities');