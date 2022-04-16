create or replace task TASK_TMS_EXECUTIONLOADPRICESHEET_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_ExecutionLoadPriceSheet')
	as call Conformed.TMS_FactExecutionLoadPriceSheet_Add('tms_ExecutionLoadPriceSheet');