create or replace TABLE BW_HA_USER_USAGE_ECC (
	ZASSIGN VARCHAR(32),
	ZCOMP VARCHAR(40),
	ZPERTYPE VARCHAR(1),
	ZPERSTRT VARCHAR(8),
	ZTASKTYP VARCHAR(1),
	ZENTRY VARCHAR(60),
	ZTRANSC VARCHAR(1),
	ZUSER VARCHAR(12),
	CLIENT VARCHAR(3),
	RECORDMODE VARCHAR(1),
	ZCOUNTR NUMBER(38,3),
	ZFSTNAME VARCHAR(60),
	ZLSTNAME VARCHAR(60),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);