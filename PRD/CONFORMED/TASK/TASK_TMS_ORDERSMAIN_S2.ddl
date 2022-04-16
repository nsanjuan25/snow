create or replace task TASK_TMS_ORDERSMAIN_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_OrdersMain')
	as call Conformed.TMS_FactOrders_Add ('tms_OrdersMain');