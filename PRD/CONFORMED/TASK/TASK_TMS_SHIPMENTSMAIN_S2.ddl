create or replace task TASK_TMS_SHIPMENTSMAIN_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_ShipmentsMain')
	as call Conformed.TMS_FactShipmentsMain_Add ('tms_ShipmentsMain');