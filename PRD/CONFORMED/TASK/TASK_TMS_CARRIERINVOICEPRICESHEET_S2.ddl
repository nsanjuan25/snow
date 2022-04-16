create or replace task TASK_TMS_CARRIERINVOICEPRICESHEET_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_CarrierInvoicePriceSheet')
	as call Conformed.TMS_FactCarrierInvoicePriceSheet_Add('tms_CarrierInvoicePriceSheet');