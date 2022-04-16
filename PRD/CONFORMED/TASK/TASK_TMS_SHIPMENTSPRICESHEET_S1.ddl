create or replace task TASK_TMS_SHIPMENTSPRICESHEET_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_ShipmentsPriceSheet')
	as call Conformed.TMS_FactShipmentsPriceSheet_Add('tms_ShipmentsPriceSheet');