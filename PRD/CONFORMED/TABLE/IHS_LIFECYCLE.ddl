create or replace TABLE IHS_LIFECYCLE (
	PART_OBJECTID NUMBER(38,0) NOT NULL,
	MANUFACTURER_OBJECTID VARCHAR(16777216),
	MANUFACTURER_PART_NUMBER VARCHAR(16777216),
	MANUFACTURER_FULL_NAME VARCHAR(16777216),
	PART_STATUS VARCHAR(16777216),
	LIFE_CYCLE_STAGE VARCHAR(16777216),
	LIFE_CYCLE_CODE VARCHAR(16777216),
	DATE_OF_INTRO VARCHAR(16777216),
	AVAILABILITYYTEOL VARCHAR(16777216),
	ESTIMATED_YTEOL VARCHAR(16777216),
	LIFE_CYCLE_COMMENTS VARCHAR(16777216),
	ALERT_PREDICTION_DATE VARCHAR(16777216),
	LIFE_CYCLE_INFORMATION_SOURCE VARCHAR(16777216),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9),
	primary key (PART_OBJECTID)
);