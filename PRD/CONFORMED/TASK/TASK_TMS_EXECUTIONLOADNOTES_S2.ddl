create or replace task TASK_TMS_EXECUTIONLOADNOTES_S2
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_TMS_SCHEDULE2
	when SYSTEM$STREAM_HAS_DATA('Conformed.stm_tms_ExecutionLoadNotes')
	as call Conformed.TMS_DimExecutionLoadNotes_Add ('tms_ExecutionLoadNotes');