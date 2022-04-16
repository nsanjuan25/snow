create or replace task TASK_TMS_CARRIERINVOICEMAIN_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_CarrierInvoiceMain')
	as call Conformed.TMS_FactCarrierInvoices_Add ('tms_CarrierInvoiceMain');