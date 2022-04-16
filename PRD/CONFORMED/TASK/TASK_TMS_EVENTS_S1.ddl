create or replace task TASK_TMS_EVENTS_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call Conformed.TMS_FactEvents_Add ('tms_Events');