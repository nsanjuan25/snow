create or replace task TASK_TMS_SHIPPINGORDERSMAIN_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_ShippingOrdersMain')
	as call Conformed.TMS_FactShippingOrders_Add ('tms_ShippingOrdersMain');