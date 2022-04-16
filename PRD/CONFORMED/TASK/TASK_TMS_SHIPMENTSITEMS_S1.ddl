create or replace task TASK_TMS_SHIPMENTSITEMS_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call Conformed.TMS_FactShipmentsItems_Add ('tms_ShipmentsItems');