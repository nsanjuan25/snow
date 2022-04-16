create or replace TABLE ECC_HA_ZMDOS (
	MANDT VARCHAR(3),
	WERKS VARCHAR(4),
	MATNR VARCHAR(18),
	LIFNR VARCHAR(10),
	DOS_FORMULA VARCHAR(2),
	NR_DAY NUMBER(38,0),
	WK_DAY NUMBER(38,0),
	DOS_CALC NUMBER(38,0),
	DOS_MIN NUMBER(38,0),
	DOS_MAX NUMBER(38,0),
	CAL_MIN_STK_L NUMBER(38,0),
	CAL_MAX_STK_L NUMBER(38,0),
	OVE_MIN_STK_L NUMBER(38,0),
	OVE_MAX_STK_L NUMBER(38,0),
	TRA_MIN_STK_L NUMBER(38,0),
	TRA_MAX_STK_L NUMBER(38,0),
	PRE_MIN_STK_L NUMBER(38,0),
	PRE_MAX_STK_L NUMBER(38,0),
	LAST_CHG VARCHAR(8),
	SUPPLIER_CODE VARCHAR(10),
	CUST_MATERIAL_NO VARCHAR(18),
	LIABILITY_WINDOW VARCHAR(3),
	RMV_IND VARCHAR(1),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);