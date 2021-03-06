create or replace TABLE JPS_HA_TCURF (
	MANDT VARCHAR(3),
	KURST VARCHAR(4),
	FCURR VARCHAR(5),
	TCURR VARCHAR(5),
	GDATU VARCHAR(8),
	FFACT NUMBER(38,0),
	TFACT NUMBER(38,0),
	ABWCT VARCHAR(4),
	ABWGA VARCHAR(8),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);