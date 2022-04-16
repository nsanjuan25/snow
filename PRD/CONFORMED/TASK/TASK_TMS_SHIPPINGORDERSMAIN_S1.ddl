create or replace task TASK_TMS_SHIPPINGORDERSMAIN_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call Conformed.TMS_FactShippingOrders_Add ('tms_ShippingOrdersMain');