create or replace task TASK_INCONTROL_TMS_FACTTGCS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_TGCS_S1
	as call InControl_TMS_FactTgcs();