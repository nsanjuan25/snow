create or replace task TASK_INCONTROL_TMS_FACTEVENTS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_EVENTS_S1
	as call InControl_TMS_FactEvents();