create or replace view V_TASK_MONITOR(
	JOBNAME,
	NAME,
	NAME_AT_LEVEL,
	LEVEL,
	OWNER,
	COMMENT,
	WAREHOUSE,
	SCHEDULE,
	STATE,
	DEFINITION,
	CREATED_ON,
	LAST_RUN_STATE,
	ERROR_MESSAGE,
	SCHEDULED_TIME,
	COMPLETED_TIME,
	DURATION,
	PREDECESSOR,
	PATH,
	UPDATEDON
) as 
SELECT
    CASE 
          WHEN LEVEL = 1 THEN CONCAT('PRD.CONFORMED.', NAME)
      ELSE 
          TRIM( SUBSTRING( Path, 4, CHARINDEX('->', Path, 3) -4 ) )
       END AS JobName
    , Name
    , Name_at_Level
    , Level 
    , Owner
    , Comment
    , Warehouse
    , Schedule
    , State
    , Definition
    , Created_On
    , Last_Run_State
    , Error_Message
    , Scheduled_Time
    , Completed_Time
    , Duration
    , Predecessor
    , Path
    , UpdatedOn
FROM
    Conformed.TASKTREE;