create or replace task TASK_DIMMANUFACTURERPARTS
	warehouse=WH_TASKS
	after PRD.CONFORMED.TASK_DIMMANUFACTURERS
	as call conformed.DIMMANUFACTURERPARTS_ADD();