create or replace task TASK_TMS_EXECUTIONLOADSHIPUNITS_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	as call Conformed.TMS_FactExecutionLoadShipUnits_Add('tms_ExecutionLoadShipUnits');