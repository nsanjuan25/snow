create or replace task TASK_TMS_EXECUTIONLOADMAIN_S1
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE1
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_ExecutionLoadMain')
	as call Conformed.TMS_FactExecutionLoadMain_Add ('tms_ExecutionLoadMain');