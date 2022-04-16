create or replace task TASK_TMS_TGCS_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call Conformed.TMS_FactTgcs_Add ('tms_Tgcs');