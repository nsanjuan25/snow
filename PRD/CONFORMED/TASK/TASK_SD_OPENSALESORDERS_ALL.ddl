create or replace task TASK_SD_OPENSALESORDERS_ALL
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_AMERICANGIRL
	as CALL CONFORMED.SD_OPENSALESORDERS_ALL_UNLOAD();