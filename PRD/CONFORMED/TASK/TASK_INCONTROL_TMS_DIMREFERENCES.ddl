create or replace task TASK_INCONTROL_TMS_DIMREFERENCES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_ORDERSREFERENCES_S1
	as call InControl_TMS_DimReferences();