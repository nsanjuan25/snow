create or replace task TASK_INCONTROL_UNOAD_SCMCOMPLIANCE_FACILITIESANDFACILITYTYPES
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_SCMCOMPLIANCE_FACILITIESANDFACILITYTYPES
	as call CONFORMED.InControl_SCMCompliance_FACILITIESANDFACILITYTYPES();