create or replace task TASK_TMS_ORDERSREFERENCES_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call CONFORMED.TMS_DimReferences_Add ('tms_OrdersReferences');