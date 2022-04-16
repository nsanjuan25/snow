create or replace TABLE JPS_HA_TCURR (
	MANDT VARCHAR(3),
	KURST VARCHAR(4),
	FCURR VARCHAR(5),
	TCURR VARCHAR(5),
	GDATU VARCHAR(8),
	UKURS NUMBER(38,5),
	FFACT NUMBER(38,0),
	TFACT NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);