create or replace task TASK_INCONTROL_TMS_FACTSHIPPINGORDERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_SHIPPINGORDERSMAIN_S1
	as call InControl_TMS_FactShippingOrders();