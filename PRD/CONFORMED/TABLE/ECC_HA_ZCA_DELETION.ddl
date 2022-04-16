create or replace TABLE ECC_HA_ZCA_DELETION (
	MANDT VARCHAR(3),
	ZTABLE VARCHAR(30),
	VALUE VARCHAR(255),
	SEQGEN NUMBER(38,0),
	ZZDATE VARCHAR(8),
	TIMESTAMP VARCHAR(14),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);