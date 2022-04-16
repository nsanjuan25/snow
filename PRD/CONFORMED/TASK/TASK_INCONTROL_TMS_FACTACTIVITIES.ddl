create or replace task TASK_INCONTROL_TMS_FACTACTIVITIES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_ACTIVITIES_S1
	as call InControl_TMS_FactActivites();