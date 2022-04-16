create or replace task TASK_TMS_CUSTOMERINVOICEMAIN_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('CONFORMED.stm_tms_CustomerInvoiceMain')
	as call Conformed.TMS_FactCustomerInvoices_Add ('tms_CustomerInvoiceMain');