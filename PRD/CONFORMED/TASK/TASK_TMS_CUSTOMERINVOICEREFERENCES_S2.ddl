create or replace task TASK_TMS_CUSTOMERINVOICEREFERENCES_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_CustomerInvoiceReferences')
	as call Conformed.TMS_DimReferences_Add ('tms_CustomerInvoiceReferences');