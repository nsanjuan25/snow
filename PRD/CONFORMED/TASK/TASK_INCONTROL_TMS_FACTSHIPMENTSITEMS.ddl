create or replace task TASK_INCONTROL_TMS_FACTSHIPMENTSITEMS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call InControl_TMS_FactShipmentsItems();