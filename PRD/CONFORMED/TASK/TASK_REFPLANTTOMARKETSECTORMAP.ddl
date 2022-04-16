create or replace task TASK_REFPLANTTOMARKETSECTORMAP
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_MATERIALS
	as call conformed.RefPlantToMarketSectorMap_ADD();