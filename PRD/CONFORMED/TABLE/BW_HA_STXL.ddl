create or replace TABLE BW_HA_STXL (
	RELID VARCHAR(2),
	TDOBJECT VARCHAR(10),
	TDNAME VARCHAR(60),
	TDID VARCHAR(4),
	TDSPRAS VARCHAR(1),
	SDATA VARCHAR(50),
	SDATA2 VARCHAR(50),
	SDATA3 VARCHAR(50),
	SDATA4 VARCHAR(50),
	SDATA5 VARCHAR(50),
	SDATA6 VARCHAR(50),
	SDATA7 VARCHAR(50),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);