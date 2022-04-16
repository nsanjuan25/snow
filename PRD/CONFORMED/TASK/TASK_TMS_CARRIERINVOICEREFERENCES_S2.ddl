create or replace task TASK_TMS_CARRIERINVOICEREFERENCES_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_CarrierInvoiceReferences')
	as call Conformed.TMS_DimReferences_Add ('tms_CarrierInvoiceReferences');