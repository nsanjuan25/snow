create or replace task TASK_DIMTM1CUSTOMERSECURITY
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_START_FOOTPRINT
	as call conformed.DimTM1CostCenterSecurity_ADD();