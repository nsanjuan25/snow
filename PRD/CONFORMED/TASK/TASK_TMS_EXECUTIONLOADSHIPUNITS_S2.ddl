create or replace task TASK_TMS_EXECUTIONLOADSHIPUNITS_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('CONFORMED.stm_tms_ExecutionLoadShipUnits')
	as call Conformed.TMS_FactExecutionLoadShipUnits_Add('tms_ExecutionLoadShipUnits');