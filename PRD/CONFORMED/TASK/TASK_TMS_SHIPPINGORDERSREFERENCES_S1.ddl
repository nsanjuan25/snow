create or replace task TASK_TMS_SHIPPINGORDERSREFERENCES_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	when SYSTEM$STREAM_HAS_DATA('CONFORMED.stm_tms_ShippingOrdersReferences')
	as call CONFORMED.TMS_DimReferences_Add ('tms_ShippingOrdersReferences');