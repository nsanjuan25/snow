create or replace task TASK_DIMREASONTYPES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.DIMREASONTYPES_ADD();