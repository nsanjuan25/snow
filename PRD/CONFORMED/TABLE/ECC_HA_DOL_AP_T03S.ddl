create or replace TABLE ECC_HA_DOL_AP_T03S (
	MANDT VARCHAR(3),
	PROJECT_ID VARCHAR(10),
	DCON VARCHAR(4),
	STATS VARCHAR(3),
	SUBSTATS VARCHAR(3),
	LANGU VARCHAR(1),
	STDES VARCHAR(60),
	VVALU1 VARCHAR(10),
	VVALU2 VARCHAR(10),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);