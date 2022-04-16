create or replace task TASK_FACTMOVEMENTS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMAML
	as call conformed.FactMovements_ADD();