create or replace TABLE BW_HA_PKG_UT2 (
	WERKS VARCHAR(4),
	VERAN VARCHAR(10),
	PROD_DATE VARCHAR(8),
	SHIFT VARCHAR(4),
	AVAILHRS NUMBER(38,3),
	TM NUMBER(38,3),
	CALYEAR VARCHAR(4),
	CALMONTH VARCHAR(6),
	CALWEEK VARCHAR(6),
	PDT NUMBER(38,3),
	ZMDTHRS NUMBER(38,3),
	LMNGA NUMBER(38,3),
	XMNGA NUMBER(38,3),
	ACTOPHRS NUMBER(38,3),
	A_OPERATORS NUMBER(38,3),
	ZCSTPC NUMBER(38,3),
	ZCSTPKG NUMBER(38,3),
	ZCSTRES NUMBER(38,3),
	CSTASSY NUMBER(38,3),
	ZLABCST_A NUMBER(38,3),
	ZLABCST_C NUMBER(38,3),
	A_ISM02 NUMBER(38,3),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);