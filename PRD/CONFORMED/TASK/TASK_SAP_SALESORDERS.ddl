create or replace task TASK_SAP_SALESORDERS
	warehouse=WH_TASKS_01
	after PRD.CONFORMED.TASK_START_SALESORDERS
	as CALL CONFORMED.SAP_SALESORDERS_ADD();