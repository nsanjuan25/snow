create or replace task TASK_INCONTROL_UNOAD_SCMCOMPLIANCE_COMMODITIES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_SCMCOMPLIANCE_COMMODITIES
	as call CONFORMED.InControl_SCMCompliance_Commodities();