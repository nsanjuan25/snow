create or replace TABLE ECC_HA_T030 (
	MANDT VARCHAR(3),
	KTOPL VARCHAR(4),
	KTOSL VARCHAR(3),
	BWMOD VARCHAR(4),
	KOMOK VARCHAR(3),
	BKLAS VARCHAR(4),
	KONTS VARCHAR(10),
	KONTH VARCHAR(10),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);