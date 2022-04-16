create or replace task TASK_INCONTROL_TMS_FACTORDERS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_ORDERSMAIN_S1
	as call InControl_TMS_FactOrders();