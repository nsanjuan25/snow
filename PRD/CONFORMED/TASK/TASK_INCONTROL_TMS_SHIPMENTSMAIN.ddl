create or replace task TASK_INCONTROL_TMS_SHIPMENTSMAIN
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_TMS_SHIPMENTSMAIN_S1
	as call InControl_TMS_FactShipmentsMain();